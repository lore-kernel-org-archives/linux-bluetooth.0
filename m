Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 7 Dec 2016 15:16:42 -0500
From: Don Zickus <dzickus@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Brennan Ashton <brn@deako.com>
Subject: Re: [RFC 0/3] core/adapter: Add disabling duplicate device filtering
 from d-bus
Message-ID: <20161207201642.GF35881@redhat.com>
References: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
 <CABBYNZLdm5TsxZeCzS0S_7Xf0sfqYPNy8YrOMTpOsL3pNUO0jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLdm5TsxZeCzS0S_7Xf0sfqYPNy8YrOMTpOsL3pNUO0jA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 07, 2016 at 12:21:58PM +0200, Luiz Augusto von Dentz wrote:
> Hi Don,
> 
> On Tue, Dec 6, 2016 at 11:39 PM, Don Zickus <dzickus@redhat.com> wrote:
> > Recent discussions on the bluez mailing list revealed it was not easy
> > to disable duplicate device filtering from the d-bus interface.
> >
> > As a result, if I wanted to monitor LE devices entering and leaving the
> > adapters range (using RSSI data), it was difficult.
> >
> > This patchset is a dirty hack to make this work. The first patch enables
> > it on the kernel side, while the other two patches enable it from the bluez
> > side.
> >
> > I understand there are concerns about flooding the d-bus interface when
> > enabling this.  I tried to write a throttling mechanism using the mainloop
> > as my timer, but soon realized you can only have 1 device RSSI event
> > per loop, so that wasn't going to work.  Open to suggestions if still a
> > concern.
> >
> > Posted as an RFC just to generate discussion.  I expect I missed a lot of
> > little details here, but wanted to post my proof of concept to see if this
> > is something to work with.
> >
> > This patchset includes both the kernel and bluez patches.  I understand this is
> > not recommended for normal practice.  But I thought for an RFC, it is nice to
> > keep things together for now.
> 
> I would avoid adding a new MGMT command and instead disabled
> duplicated filtering if RSSI filtering is set since anyway RSSI
> filtering needs to disable duplicates in order to do any RSSI
> filtering reliable. So this would mean that if the user wants to see
> to get duplicate filtering it needs to set a RSSI which should rate
> limit as we would use a threshold.

Hi Luiz,

Ok, fair enough.  I then simplified it down to a small kernel patch that
seems to work if I set an RSSI threshold with SetDiscoveryFilter.

I only do this on an active_scan.  Not sure if I should do it for the
passive scans too?

If this looks ok, I will resubmit properly.

Cheers,
Don


diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 554671c..fd34707 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -79,6 +79,7 @@ struct discovery_state {
 	bool			report_invalid_rssi;
 	bool			result_filtering;
 	bool			limited;
+	bool			filter_dups;
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1015d9c..8b5ee64 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2038,7 +2038,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 
 	memset(&enable_cp, 0, sizeof(enable_cp));
 	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	enable_cp.filter_dup = hdev->discovery.filter_dups;
 
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 		    &enable_cp);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fba2a0..0ac6e6f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3578,6 +3578,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd;
 	const u16 max_uuid_count = ((U16_MAX - sizeof(*cp)) / 16);
 	u16 uuid_count, expected_len;
+	bool filter_dups = LE_SCAN_FILTER_DUP_ENABLE;
 	u8 status;
 	int err;
 
@@ -3631,6 +3632,9 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (cp->rssi)
+		filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
 			       hdev, data, len);
 	if (!cmd) {
@@ -3649,6 +3653,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	hdev->discovery.type = cp->type;
 	hdev->discovery.rssi = cp->rssi;
 	hdev->discovery.uuid_count = uuid_count;
+	hdev->discovery.filter_dups = filter_dups;
 
 	if (uuid_count > 0) {
 		hdev->discovery.uuids = kmemdup(cp->uuids, uuid_count * 16,
