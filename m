Return-Path: <martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: mark.rutland@arm.com,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	gregkh@linuxfoundation.org,
	jslaby@suse.com,
	johan@kernel.org,
	linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net,
	carlo@endlessm.com,
	drake@endlessm.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v2 1/9] serdev: implement parity configuration
Date: Mon,  1 Jan 2018 21:42:09 +0100
Message-Id: <20180101204217.26165-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Some Bluetooth modules (for example the ones found in Realtek RTL8723BS
and RTL8723DS) want to communicate with the host with even parity
enabled.
Add a new function and the corresponding internal callbacks so parity
can be configured. This supports enabling and disabling parity as well
as setting the type to odd or even.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/tty/serdev/core.c           | 12 ++++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 21 +++++++++++++++++++++
 include/linux/serdev.h              |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 1bef39828ca7..d327b02980f5 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -225,6 +225,18 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
 
+void serdev_device_set_parity(struct serdev_device *serdev, bool enable,
+			      bool odd)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_parity)
+		return;
+
+	ctrl->ops->set_parity(ctrl, enable, odd);
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_parity);
+
 void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 247788a16f0b..36bed86e5c96 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -190,6 +190,26 @@ static void ttyport_set_flow_control(struct serdev_controller *ctrl, bool enable
 	tty_set_termios(tty, &ktermios);
 }
 
+static void ttyport_set_parity(struct serdev_controller *ctrl, bool enable,
+			       bool odd)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	struct ktermios ktermios = tty->termios;
+
+	if (enable)
+		ktermios.c_cflag |= PARENB;
+	else
+		ktermios.c_cflag &= ~PARENB;
+
+	if (odd)
+		ktermios.c_cflag |= PARODD;
+	else
+		ktermios.c_cflag &= ~PARODD;
+
+	tty_set_termios(tty, &ktermios);
+}
+
 static void ttyport_wait_until_sent(struct serdev_controller *ctrl, long timeout)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
@@ -227,6 +247,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.open = ttyport_open,
 	.close = ttyport_close,
 	.set_flow_control = ttyport_set_flow_control,
+	.set_parity = ttyport_set_parity,
 	.set_baudrate = ttyport_set_baudrate,
 	.wait_until_sent = ttyport_wait_until_sent,
 	.get_tiocm = ttyport_get_tiocm,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index d609e6dc5bad..07f2d4d4e88c 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -86,6 +86,7 @@ struct serdev_controller_ops {
 	int (*open)(struct serdev_controller *);
 	void (*close)(struct serdev_controller *);
 	void (*set_flow_control)(struct serdev_controller *, bool);
+	void (*set_parity)(struct serdev_controller *, bool, bool);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
 	void (*wait_until_sent)(struct serdev_controller *, long);
 	int (*get_tiocm)(struct serdev_controller *);
@@ -195,6 +196,7 @@ int serdev_device_open(struct serdev_device *);
 void serdev_device_close(struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
+void serdev_device_set_parity(struct serdev_device *, bool, bool);
 int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
@@ -237,6 +239,9 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
 	return 0;
 }
 static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
+static inline void serdev_device_set_parity(struct serdev_device *sdev,
+					    bool enable,
+					    bool odd) {}
 static inline int serdev_device_write_buf(struct serdev_device *serdev,
 					  const unsigned char *buf,
 					  size_t count)
-- 
2.15.1
