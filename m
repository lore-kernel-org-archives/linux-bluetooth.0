Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769740;
	b=o8Pu8xMZc4EDdgFpGyc6uwISzXJJNA6nlgY1RDJxQ1lKqHFXRgNVCaZIlhNs66T2gByh
	 6RlAh9sZU0ghS3Ix499+epxIbtvDH8ztrnYhZVMyLjQERS2YkcL7JqdVnal8dC5vinE4R
	 5xqu5xARxxY+nmzA8TLefA181aFfAWsF++aYf92vLyb09mHYAH7eAVI6Z+GlvyDpmNif+
	 LgZr7zYKIHHjWdBWjiW9Ma+qvJnSM/nvas2OsWSC+uUUh1ZSRgE5AGQ573TPJvC7Zz207
	 tfGrBWaZwT39WOvOHyUZb7J/O435dbFG5fVJJvZDEIekZ0dSfK7numO8UDgcAKABqVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KfyoOSDGvVrYRNKElNYbnsag/qbQypAtRdT9m3QRxG8=;
	b=Rl8XXpaeajdAkxgdcYS/aXgl61TBCPuCFQjOEcg5nEjMqIHDfRuFfyOseysL0LYGXZEz
	 RoboTPhERs4U32HZIcm6y5B67CcaOYKqWpSUeDC6LnfP0ygbwRWC5BCR7HzX6lOyB4V5E
	 d0SCXjw9wqzkWc5xT3Rncxnb8xXuXyZQaXHDuyp4pg3rTCgyL14Vc3lIkP6xvoDgVwxxv
	 w8ufOi94ZK/FPfbjYBtBxLikosU8GvLAayuLT0vWYZI//DP6rTk4qWTVvdt1yIDM+LaAg
	 ThuPQ25qd4s+cmvP3GMZxRzzle+AFdzsGr1JEzPG4DVQ8CwWJq7JxaT3UtBdunvzryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F80iK+mh;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E5606A335
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 488E5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F80iK+mh
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a3ac4ac65bso447794f8f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769739; x=1796374539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfyoOSDGvVrYRNKElNYbnsag/qbQypAtRdT9m3QRxG8=;
        b=F80iK+mhB07Mw1bUrg0i1WT0+V/T1dLB1AMaD/dwS6QpJCK6e5djKl12D0IfAizqRN
         9YoNdTKA8dOVStUfubh/8b7+kTAlAz/4jV/FbdYeCps703GlW7CRIkPrEaTz4Z7BsuzN
         YppdEg8CA58UwsvprKJvhGrnALCoefI7qQvJo2GypBiI8eaWdHP5TB9+eVmEMF9YMTQ8
         2HtNmrmwlgX6MuZ8QEOlm5QZUnRLsRgXh2i0NeEo96n29O8dWII/DFFWkjjM86dIYPSL
         eK3H5ec+xSu9R4TnzzDCvdOt7myl11YR0KiMCpNDyHzAXj7k+aafDBa+A+4K03pDZIpj
         uyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769739; x=1796374539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KfyoOSDGvVrYRNKElNYbnsag/qbQypAtRdT9m3QRxG8=;
        b=ir98A3Yqyc1Mt2/2q/RtvJaNJuCWMcifG2bRP49/KeDsSqtwx+8O0C3cdHxU6j4TK3
         Z1usZBm+6R+spj9HSzLJGhwXSRmiGhasiYwgj7tUPs3KRMwl8a5/EnmnqnVHcOYIyCOq
         ia2+HluxW7RTkKlhGIns+qHqkDdjxP7T5M8Wrk8y/B+SDMK/lUX7PXTnBb1hCgA9FSdR
         ExjpLGMg5HoDUI7aZoPstOl+KnKA32z1tcATn7td1WtivC+DR54AYp+mFUy9Z/OBLjnA
         rrM4eWNrHqb8ZJsxjNpoT0aObHxhUnF9yZZ/dzJ6vxWkSHkNLMQcTgdvL0vdoOrwp2Ak
         0xPA==
X-Gm-Message-State: APuU4Z/1grCWXjlcBpiGW8cy/bFfsrA9wnWIlOJLmvxs00DmWp+mJW3N
	Fyr9ewNhGjHvPlZkhByZUZw/MhgQOR3rKhxtnVgPAjXKwdmalRBb8wy5kRbht13w
X-Gm-Gg: AZFdTZeauGckH/bZMKLNQLYSbeG9jd6Wtsnw5++DiedYhxh8+aQQMddVlH9DzNtil8l
	NWnKpz8W4eIRLBqdih0V3soBfg6sXurc2XA+l4q/ROQ+hFqLdpdnHGkq8jzFmYEC5HfFsgYgyah
	HcvQk0nNUUuAK78Gqc96JxhJYUDELrquF6ldOsCJh6eaQBjEx5EeJ2lk4WlN4bYejaVAGeFesgr
	O8xilEfrlAhbqnbnblXj/41GlDRIEcsLXMrXI9M2U8U8VoFulO+H1cdAks96xJFQU+Cg2I2frOe
	VfQ0Mnk8vmY0soVx/Tigrh8crmOBLjy/KxVnTDhppWdAZb/DKGJZoDulvtXGWkJcuJ6NXAzaTQb
	Qt7PE9Ucy9B4xojbSinRTf5ripsOGOSYt6vFjMPk7rALImN3YqxVqr46NC/SlM1qs7uUjBQra6x
	wMrOA9LL8b5Cpc8GeNZ4mtqjUHRAFpxWUTc8Ocbc7hEOW0u0vMxHHgX6YhAEwbbgtdbfxirsCKG
	8rFaaDbfSeLfmCnkAOvSGgvALWWqD5RmYSCbWAO3QLfhtbzoZjPTJL04sGjim7e6p41seCuzy25
	CnqFp+yp/LZFIsI9gBXkfKN7PEJZTdeJH0o=
X-Received: by 2002:a05:600c:8206:b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4bb88787d87mr410472855e9.0.1795769738520;
        Fri, 27 Nov 2026 00:55:38 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:38 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 4/9] client/mgmt: Add pa-params, pa-data and pawr-serve commands
Date: Fri, 27 Nov 2026 09:55:20 +0100
Message-ID: <20261127085525.264299-5-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pa-params adds periodic advertising to an instance created with
add-ext-adv-params, with the parameters of Periodic Advertising with
Responses if subevents are given. pa-data sets the data of a periodic
advertising train.

pawr-serve answers the subevent data requests of an instance, with
the data given or with manufacturer data which carries the subevent
and a counter, and prints the response reports. It runs until it is
stopped.

Assisted-by: Claude:claude-fable-5-2
---
 client/mgmt.c | 275 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index a7069e5bb..be0d7cf90 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -2504,6 +2504,267 @@ static void cmd_hci_cmd(int argc, char **argv)
 	}
 }
 
+static void pa_params_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_rp_add_periodic_adv_params *rp = param;
+
+	if (status != 0) {
+		error("Add Periodic Advertising Parameters failed with status "
+				"0x%02x (%s)", status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len < sizeof(*rp)) {
+		error("Too small (%u bytes) reply", len);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Periodic advertising set on instance %u", rp->instance);
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_pa_params(int argc, char **argv)
+{
+	struct mgmt_cp_add_periodic_adv_params cp;
+	uint16_t index;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.instance = strtoul(argv[1], NULL, 0);
+	cp.min_interval = cpu_to_le16(strtoul(argv[2], NULL, 0));
+	cp.max_interval = cpu_to_le16(strtoul(argv[3], NULL, 0));
+
+	if (argc > 4) {
+		if (argc != 9) {
+			error("Either none or all five PAwR parameters");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		cp.num_subevents = strtoul(argv[4], NULL, 0);
+		cp.subevent_interval = strtoul(argv[5], NULL, 0);
+		cp.response_slot_delay = strtoul(argv[6], NULL, 0);
+		cp.response_slot_spacing = strtoul(argv[7], NULL, 0);
+		cp.num_response_slots = strtoul(argv[8], NULL, 0);
+	}
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (mgmt_send(mgmt, MGMT_OP_ADD_PERIODIC_ADV_PARAMS, index,
+			sizeof(cp), &cp, pa_params_rsp, NULL, NULL) == 0) {
+		error("Unable to send Add Periodic Advertising Parameters");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+static void pa_data_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_rp_add_periodic_adv_data *rp = param;
+
+	if (status != 0) {
+		error("Add Periodic Advertising Data failed with status "
+				"0x%02x (%s)", status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len < sizeof(*rp)) {
+		error("Too small (%u bytes) reply", len);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Periodic advertising data set on instance %u", rp->instance);
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_pa_data(int argc, char **argv)
+{
+	uint8_t buf[sizeof(struct mgmt_cp_add_periodic_adv_data) + 252];
+	struct mgmt_cp_add_periodic_adv_data *cp = (void *) buf;
+	long data_len = 0;
+	uint16_t index;
+
+	memset(buf, 0, sizeof(buf));
+	cp->instance = strtoul(argv[1], NULL, 0);
+
+	if (argc > 2) {
+		data_len = 252;
+		if (!str2bytearray(argv[2], cp->data, &data_len))
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	cp->data_len = data_len;
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (mgmt_send(mgmt, MGMT_OP_ADD_PERIODIC_ADV_DATA, index,
+			sizeof(*cp) + data_len, cp, pa_data_rsp, NULL,
+			NULL) == 0) {
+		error("Unable to send Add Periodic Advertising Data");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+/* What pawr-serve answers the subevent data requests with */
+static struct {
+	uint8_t instance;
+	uint8_t num_subevents;
+	uint8_t num_response_slots;
+	uint8_t data[251];
+	long data_len;
+	uint8_t counter;
+} pawr;
+
+static void pawr_data_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		error("Set Periodic Advertising Subevent Data failed with "
+			"status 0x%02x (%s)", status, mgmt_errstr(status));
+}
+
+static void pawr_data_request(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_pa_subevent_data_request *ev = param;
+	uint8_t buf[sizeof(struct mgmt_cp_set_pa_subevent_data) + 253];
+	struct mgmt_cp_set_pa_subevent_data *cp = (void *) buf;
+	size_t pos = sizeof(*cp);
+	uint8_t i;
+
+	if (len < sizeof(*ev)) {
+		error("Too small (%u bytes) pa_subevent_data_request event",
+									len);
+		return;
+	}
+
+	if (ev->instance != pawr.instance)
+		return;
+
+	print("hci%u pa_subevent_data_request: instance %u start %u count %u",
+			index, ev->instance, ev->subevent_start,
+			ev->subevent_data_count);
+
+	cp->instance = ev->instance;
+	cp->num_subevents = 0;
+
+	for (i = 0; i < ev->subevent_data_count; i++) {
+		struct mgmt_pa_subevent_data *subevent = (void *) (buf + pos);
+		uint8_t data[sizeof(pawr.data)];
+		uint8_t data_len = pawr.data_len;
+
+		subevent->subevent = (ev->subevent_start + i) %
+							pawr.num_subevents;
+
+		/* Without data from the command line: manufacturer data
+		 * with the subevent and a counter.
+		 */
+		if (data_len) {
+			memcpy(data, pawr.data, data_len);
+		} else {
+			data[0] = 0x05;
+			data[1] = 0xff;
+			data[2] = 0x59;
+			data[3] = 0x00;
+			data[4] = subevent->subevent;
+			data[5] = pawr.counter++;
+			data_len = 6;
+		}
+
+		if (pos + sizeof(*subevent) + data_len > sizeof(buf))
+			break;
+
+		subevent->response_slot_start = 0;
+		subevent->response_slot_count = pawr.num_response_slots;
+		subevent->data_len = data_len;
+		memcpy(subevent->data, data, data_len);
+
+		pos += sizeof(*subevent) + data_len;
+		cp->num_subevents++;
+	}
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_PA_SUBEVENT_DATA, index, pos, buf,
+					pawr_data_rsp, NULL, NULL) == 0)
+		error("Unable to send Set Periodic Advertising Subevent Data");
+}
+
+static void pawr_response_report(uint16_t index, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_pa_response_report *ev = param;
+	const uint8_t *ptr;
+	uint8_t i;
+
+	if (len < sizeof(*ev)) {
+		error("Too small (%u bytes) pa_response_report event", len);
+		return;
+	}
+
+	ptr = ev->responses;
+	len -= sizeof(*ev);
+
+	for (i = 0; i < ev->num_responses; i++) {
+		const struct mgmt_pa_response *rsp = (const void *) ptr;
+		char str[2 * 251 + 1];
+		uint8_t j;
+
+		if (len < sizeof(*rsp) || len < sizeof(*rsp) + rsp->data_len) {
+			error("Truncated pa_response_report event");
+			return;
+		}
+
+		for (j = 0; j < rsp->data_len; j++)
+			sprintf(str + 2 * j, "%02x", rsp->data[j]);
+		str[2 * rsp->data_len] = '\0';
+
+		print("hci%u pa_response_report: instance %u subevent %u "
+			"tx_status %u slot %u rssi %d status 0x%02x data %s",
+			index, ev->instance, ev->subevent, ev->tx_status,
+			rsp->response_slot, rsp->rssi, rsp->data_status, str);
+
+		ptr += sizeof(*rsp) + rsp->data_len;
+		len -= sizeof(*rsp) + rsp->data_len;
+	}
+}
+
+/* Runs until it is stopped */
+static void cmd_pawr_serve(int argc, char **argv)
+{
+	uint16_t index;
+
+	memset(&pawr, 0, sizeof(pawr));
+	pawr.instance = strtoul(argv[1], NULL, 0);
+	pawr.num_subevents = strtoul(argv[2], NULL, 0);
+	pawr.num_response_slots = strtoul(argv[3], NULL, 0);
+
+	if (!pawr.num_subevents) {
+		error("Invalid number of subevents");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc > 4) {
+		pawr.data_len = sizeof(pawr.data);
+		if (!str2bytearray(argv[4], pawr.data, &pawr.data_len))
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	mgmt_register(mgmt, MGMT_EV_PA_SUBEVENT_DATA_REQUEST, index,
+					pawr_data_request, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_PA_RESPONSE_REPORT, index,
+					pawr_response_report, NULL, NULL);
+
+	print("Serving subevent data of instance %u", pawr.instance);
+}
+
 /* Wrapper to get the index and opcode to the response callback */
 struct command_data {
 	uint16_t id;
@@ -6354,6 +6615,20 @@ static const struct bt_shell_menu mgmt_menu = {
 		cmd_conn_subrate,	"Load Connection Subrate"	},
 	{ "hci-cmd",		"<opcode> [event] [timeout] [param...]",
 		cmd_hci_cmd,	"Send HCI Command and wait for Event"	},
+	{ "pa-params",		"<instance> <min_interval> <max_interval> "
+				"[num_subevents] [subevent_interval] "
+				"[response_slot_delay] [response_slot_spacing] "
+				"[num_response_slots]",
+		cmd_pa_params,
+			"Add periodic advertising to an instance, with "
+			"responses if it has subevents"			},
+	{ "pa-data",		"<instance> [data...]",
+		cmd_pa_data,
+			"Set the periodic advertising data of an instance" },
+	{ "pawr-serve",		"<instance> <num_subevents> "
+				"<num_response_slots> [data...]",
+		cmd_pawr_serve,
+			"Answer subevent data requests, print responses" },
 	{} },
 };
 
-- 
2.47.3

