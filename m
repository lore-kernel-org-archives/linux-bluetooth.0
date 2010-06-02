Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 2 Jun 2010 13:44:57 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Suraj <suraj@Atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH v2] frame reassembly implementation for data stream
Message-ID: <20100602164457.GB16657@vigoh>
References: <1275467080.13946.3.camel@atheros013-desktop>
 <1275490955.2182.21.camel@localhost.localdomain>
 <20100602161117.GA16657@vigoh>
 <4C0684DA.3000306@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C0684DA.3000306@Atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj <suraj@Atheros.com> [2010-06-02 21:50:42 +0530]:

> Hi Gustavo,
> 
> On 6/2/2010 9:41 PM, Gustavo F. Padovan wrote:
> >Hi Suraj,
> >
> >* Marcel Holtmann<marcel@holtmann.org>  [2010-06-02 08:02:35 -0700]:
> >
> >>Hi Suraj,
> >>
> >>>Implemented hci_recv_stream_fragment to reassemble HCI packets received from a data stream.
> >>>
> >>>Signed-off-by: suraj<suraj@Atheros.com>
> >>
> >>please fix your signed-off-by line. This is not proper.
> >>
> >>>---
> >>>  include/net/bluetooth/hci_core.h |    1 +
> >>>  net/bluetooth/hci_core.c         |   98 ++++++++++++++++++++++++++++++++++++++
> >>>  2 files changed, 99 insertions(+), 0 deletions(-)
> >>>
> >>>diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >>>index e42f6ed..6f33f11 100644
> >>>--- a/include/net/bluetooth/hci_core.h
> >>>+++ b/include/net/bluetooth/hci_core.h
> >>>@@ -428,6 +428,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
> >>>
> >>>  int hci_recv_frame(struct sk_buff *skb);
> >>>  int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
> >>>+int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
> >>>
> >>>  int hci_register_sysfs(struct hci_dev *hdev);
> >>>  void hci_unregister_sysfs(struct hci_dev *hdev);
> >>>diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >>>index 5e83f8e..ac9ccf7 100644
> >>>--- a/net/bluetooth/hci_core.c
> >>>+++ b/net/bluetooth/hci_core.c
> >>>@@ -1033,6 +1033,104 @@ EXPORT_SYMBOL(hci_recv_frame);
> >>>  /* Receive packet type fragment */
> >>>  #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 2])
> >>>
> >>>+#define __get_max_rx_size(type)					\
> >>>+		(((type) == HCI_ACLDATA_PKT) ?			\
> >>>+		HCI_MAX_FRAME_SIZE :				\
> >>>+		((type) == HCI_EVENT_PKT) ? HCI_MAX_EVENT_SIZE :\
> >>>+		HCI_MAX_SCO_SIZE)
> >>>+
> >>>+#define __get_header_len(type)					\
> >>>+		(((type) == HCI_ACLDATA_PKT) ?			\
> >>>+		HCI_ACL_HDR_SIZE :				\
> >>>+		((type) == HCI_EVENT_PKT) ? HCI_EVENT_HDR_SIZE :\
> >>>+		HCI_SCO_HDR_SIZE)
> >>
> >>This is total hackish code. Who do you think is able to read this?
> >
> >A switch sounds a way better for both macros, change that to a function
> >and use switch to compare.
> 
> Sure, I guess I was trying to be too clever there. This call is
> called only once. So, wouldn't it better to put the switch case
> directly inline rather than writing a function?
> >

It is your choice, both a inline function or the switch directly should be
good.

-- 
Gustavo F. Padovan
http://padovan.org
