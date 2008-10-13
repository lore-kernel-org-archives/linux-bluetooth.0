Return-Path: <cyrus@holtmann.org>
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: <linux-pcmcia@lists.infradead.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/49] pcmcia: use pcmcia_loop_config in bluetooth drivers
Date: Mon, 13 Oct 2008 19:47:50 +0200
Message-Id: <1223920114-19788-5-git-send-email-linux@dominikbrodowski.net>
In-Reply-To: <20081013173803.GA18569@comet.dominikbrodowski.net>
References: <20081013173803.GA18569@comet.dominikbrodowski.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the config loop helper in bluetooth pcmcia drivers.

CC: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/bluetooth/bt3c_cs.c   |  119 ++++++++++++++++------------------------
 drivers/bluetooth/btuart_cs.c |  121 ++++++++++++++++-------------------------
 drivers/bluetooth/dtl1_cs.c   |   62 +++++-----------------
 3 files changed, 108 insertions(+), 194 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 593b7c5..6ec366f 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -678,93 +678,68 @@ static void bt3c_detach(struct pcmcia_device *link)
 	kfree(info);
 }
 
-static int get_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
+static int bt3c_check_config(struct pcmcia_device *p_dev,
+			     cistpl_cftable_entry_t *cf,
+			     void *priv_data)
 {
-	int i;
-
-	i = pcmcia_get_tuple_data(handle, tuple);
-	if (i != CS_SUCCESS)
-		return i;
-
-	return pcmcia_parse_tuple(handle, tuple, parse);
-}
-
-static int first_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
-{
-	if (pcmcia_get_first_tuple(handle, tuple) != CS_SUCCESS)
-		return CS_NO_MORE_ITEMS;
-	return get_tuple(handle, tuple, parse);
+	unsigned long try = (unsigned long) priv_data;
+
+	if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
+		p_dev->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+	if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) &&
+	    (cf->io.win[0].base != 0)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		p_dev->io.BasePort1 = cf->io.win[0].base;
+		p_dev->io.IOAddrLines = (try == 0) ? 16 :
+			cf->io.flags & CISTPL_IO_LINES_MASK;
+		if (!pcmcia_request_io(p_dev, &p_dev->io))
+			return 0;
+	}
+	return -ENODEV;
 }
 
-static int next_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
+static int bt3c_check_config_notpicky(struct pcmcia_device *p_dev,
+				      cistpl_cftable_entry_t *cf,
+				      void *priv_data)
 {
-	if (pcmcia_get_next_tuple(handle, tuple) != CS_SUCCESS)
-		return CS_NO_MORE_ITEMS;
-	return get_tuple(handle, tuple, parse);
+	static unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
+	int j;
+
+	if ((cf->io.nwin > 0) && ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		for (j = 0; j < 5; j++) {
+			p_dev->io.BasePort1 = base[j];
+			p_dev->io.IOAddrLines = base[j] ? 16 : 3;
+			if (!pcmcia_request_io(p_dev, &p_dev->io))
+				return 0;
+		}
+	}
+	return -ENODEV;
 }
 
 static int bt3c_config(struct pcmcia_device *link)
 {
-	static unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
 	bt3c_info_t *info = link->priv;
-	tuple_t tuple;
-	u_short buf[256];
-	cisparse_t parse;
-	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
-	int i, j, try;
-
-	/* First pass: look for a config entry that looks normal. */
-	tuple.TupleData = (cisdata_t *)buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.Attributes = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	/* Two tries: without IO aliases, then with aliases */
-	for (try = 0; try < 2; try++) {
-		i = first_tuple(link, &tuple, &parse);
-		while (i != CS_NO_MORE_ITEMS) {
-			if (i != CS_SUCCESS)
-				goto next_entry;
-			if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-				link->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-			if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) && (cf->io.win[0].base != 0)) {
-				link->conf.ConfigIndex = cf->index;
-				link->io.BasePort1 = cf->io.win[0].base;
-				link->io.IOAddrLines = (try == 0) ? 16 : cf->io.flags & CISTPL_IO_LINES_MASK;
-				i = pcmcia_request_io(link, &link->io);
-				if (i == CS_SUCCESS)
-					goto found_port;
-			}
-next_entry:
-			i = next_tuple(link, &tuple, &parse);
-		}
-	}
+	int i;
+	unsigned long try;
+
+	/* First pass: look for a config entry that looks normal.
+	   Two tries: without IO aliases, then with aliases */
+	for (try = 0; try < 2; try++)
+		if (!pcmcia_loop_config(link, bt3c_check_config, (void *) try))
+			goto found_port;
 
 	/* Second pass: try to find an entry that isn't picky about
 	   its base address, then try to grab any standard serial port
 	   address, and finally try to get any free port. */
-	i = first_tuple(link, &tuple, &parse);
-	while (i != CS_NO_MORE_ITEMS) {
-		if ((i == CS_SUCCESS) && (cf->io.nwin > 0) && ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
-			link->conf.ConfigIndex = cf->index;
-			for (j = 0; j < 5; j++) {
-				link->io.BasePort1 = base[j];
-				link->io.IOAddrLines = base[j] ? 16 : 3;
-				i = pcmcia_request_io(link, &link->io);
-				if (i == CS_SUCCESS)
-					goto found_port;
-			}
-		}
-		i = next_tuple(link, &tuple, &parse);
-	}
+	if (!pcmcia_loop_config(link, bt3c_check_config_notpicky, NULL))
+		goto found_port;
 
-found_port:
-	if (i != CS_SUCCESS) {
-		BT_ERR("No usable port range found");
-		cs_error(link, RequestIO, i);
-		goto failed;
-	}
+	BT_ERR("No usable port range found");
+	cs_error(link, RequestIO, -ENODEV);
+	goto failed;
 
+found_port:
 	i = pcmcia_request_irq(link, &link->irq);
 	if (i != CS_SUCCESS) {
 		cs_error(link, RequestIRQ, i);
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 68d1d25..39cca28 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -607,94 +607,69 @@ static void btuart_detach(struct pcmcia_device *link)
 	kfree(info);
 }
 
-static int get_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
+static int btuart_check_config(struct pcmcia_device *p_dev,
+			       cistpl_cftable_entry_t *cf,
+			       void *priv_data)
 {
-	int i;
-
-	i = pcmcia_get_tuple_data(handle, tuple);
-	if (i != CS_SUCCESS)
-		return i;
-
-	return pcmcia_parse_tuple(handle, tuple, parse);
-}
-
-static int first_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
-{
-	if (pcmcia_get_first_tuple(handle, tuple) != CS_SUCCESS)
-		return CS_NO_MORE_ITEMS;
-	return get_tuple(handle, tuple, parse);
+	unsigned long try = (unsigned long) priv_data;
+
+	if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
+		p_dev->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+	if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) &&
+	    (cf->io.win[0].base != 0)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		p_dev->io.BasePort1 = cf->io.win[0].base;
+		p_dev->io.IOAddrLines = (try == 0) ? 16 :
+			cf->io.flags & CISTPL_IO_LINES_MASK;
+		if (!pcmcia_request_io(p_dev, &p_dev->io))
+			return 0;
+	}
+	return -ENODEV;
 }
 
-static int next_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
+static int btuart_check_config_notpicky(struct pcmcia_device *p_dev,
+					cistpl_cftable_entry_t *cf,
+					void *priv_data)
 {
-	if (pcmcia_get_next_tuple(handle, tuple) != CS_SUCCESS)
-		return CS_NO_MORE_ITEMS;
-	return get_tuple(handle, tuple, parse);
+	static unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
+	int j;
+
+	if ((cf->io.nwin > 0) && ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		for (j = 0; j < 5; j++) {
+			p_dev->io.BasePort1 = base[j];
+			p_dev->io.IOAddrLines = base[j] ? 16 : 3;
+			if (!pcmcia_request_io(p_dev, &p_dev->io))
+				return 0;
+		}
+	}
+	return -ENODEV;
 }
 
 static int btuart_config(struct pcmcia_device *link)
 {
-	static unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
 	btuart_info_t *info = link->priv;
-	tuple_t tuple;
-	u_short buf[256];
-	cisparse_t parse;
-	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
-	int i, j, try;
-
-	/* First pass: look for a config entry that looks normal. */
-	tuple.TupleData = (cisdata_t *) buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.Attributes = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	/* Two tries: without IO aliases, then with aliases */
-	for (try = 0; try < 2; try++) {
-		i = first_tuple(link, &tuple, &parse);
-		while (i != CS_NO_MORE_ITEMS) {
-			if (i != CS_SUCCESS)
-				goto next_entry;
-			if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-				link->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-			if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) && (cf->io.win[0].base != 0)) {
-				link->conf.ConfigIndex = cf->index;
-				link->io.BasePort1 = cf->io.win[0].base;
-				link->io.IOAddrLines = (try == 0) ? 16 : cf->io.flags & CISTPL_IO_LINES_MASK;
-				i = pcmcia_request_io(link, &link->io);
-				if (i == CS_SUCCESS)
-					goto found_port;
-			}
-next_entry:
-			i = next_tuple(link, &tuple, &parse);
-		}
-	}
+	int i;
+	unsigned long try;
+
+	/* First pass: look for a config entry that looks normal.
+	   Two tries: without IO aliases, then with aliases */
+	for (try = 0; try < 2; try++)
+		if (!pcmcia_loop_config(link, btuart_check_config,
+					(void *) try))
+			goto found_port;
 
 	/* Second pass: try to find an entry that isn't picky about
 	   its base address, then try to grab any standard serial port
 	   address, and finally try to get any free port. */
-	i = first_tuple(link, &tuple, &parse);
-	while (i != CS_NO_MORE_ITEMS) {
-		if ((i == CS_SUCCESS) && (cf->io.nwin > 0)
-		    && ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
-			link->conf.ConfigIndex = cf->index;
-			for (j = 0; j < 5; j++) {
-				link->io.BasePort1 = base[j];
-				link->io.IOAddrLines = base[j] ? 16 : 3;
-				i = pcmcia_request_io(link, &link->io);
-				if (i == CS_SUCCESS)
-					goto found_port;
-			}
-		}
-		i = next_tuple(link, &tuple, &parse);
-	}
+	if (!pcmcia_loop_config(link, btuart_check_config_notpicky, NULL))
+		goto found_port;
 
-found_port:
-	if (i != CS_SUCCESS) {
-		BT_ERR("No usable port range found");
-		cs_error(link, RequestIO, i);
-		goto failed;
-	}
+	BT_ERR("No usable port range found");
+	cs_error(link, RequestIO, -ENODEV);
+	goto failed;
 
+found_port:
 	i = pcmcia_request_irq(link, &link->irq);
 	if (i != CS_SUCCESS) {
 		cs_error(link, RequestIRQ, i);
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index dae45cd..e30a633 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -590,66 +590,30 @@ static void dtl1_detach(struct pcmcia_device *link)
 	kfree(info);
 }
 
-static int get_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
+static int dtl1_confcheck(struct pcmcia_device *p_dev,
+			  cistpl_cftable_entry_t *cf,
+			  void *priv_data)
 {
-	int i;
-
-	i = pcmcia_get_tuple_data(handle, tuple);
-	if (i != CS_SUCCESS)
-		return i;
-
-	return pcmcia_parse_tuple(handle, tuple, parse);
-}
-
-static int first_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
-{
-	if (pcmcia_get_first_tuple(handle, tuple) != CS_SUCCESS)
-		return CS_NO_MORE_ITEMS;
-	return get_tuple(handle, tuple, parse);
-}
-
-static int next_tuple(struct pcmcia_device *handle, tuple_t *tuple, cisparse_t *parse)
-{
-	if (pcmcia_get_next_tuple(handle, tuple) != CS_SUCCESS)
-		return CS_NO_MORE_ITEMS;
-	return get_tuple(handle, tuple, parse);
+	if ((cf->io.nwin == 1) && (cf->io.win[0].len > 8)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		p_dev->io.BasePort1 = cf->io.win[0].base;
+		p_dev->io.NumPorts1 = cf->io.win[0].len;	/*yo */
+		p_dev->io.IOAddrLines = cf->io.flags & CISTPL_IO_LINES_MASK;
+		if (!pcmcia_request_io(p_dev, &p_dev->io))
+			return 0;
+	}
+	return -ENODEV;
 }
 
 static int dtl1_config(struct pcmcia_device *link)
 {
 	dtl1_info_t *info = link->priv;
-	tuple_t tuple;
-	u_short buf[256];
-	cisparse_t parse;
-	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
 	int i;
 
-	tuple.TupleData = (cisdata_t *)buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.Attributes = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-
 	/* Look for a generic full-sized window */
 	link->io.NumPorts1 = 8;
-	i = first_tuple(link, &tuple, &parse);
-	while (i != CS_NO_MORE_ITEMS) {
-		if ((i == CS_SUCCESS) && (cf->io.nwin == 1) && (cf->io.win[0].len > 8)) {
-			link->conf.ConfigIndex = cf->index;
-			link->io.BasePort1 = cf->io.win[0].base;
-			link->io.NumPorts1 = cf->io.win[0].len;	/*yo */
-			link->io.IOAddrLines = cf->io.flags & CISTPL_IO_LINES_MASK;
-			i = pcmcia_request_io(link, &link->io);
-			if (i == CS_SUCCESS)
-				break;
-		}
-		i = next_tuple(link, &tuple, &parse);
-	}
-
-	if (i != CS_SUCCESS) {
-		cs_error(link, RequestIO, i);
+	if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
 		goto failed;
-	}
 
 	i = pcmcia_request_irq(link, &link->irq);
 	if (i != CS_SUCCESS) {
-- 
1.5.4.3
