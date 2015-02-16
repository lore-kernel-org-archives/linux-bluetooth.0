Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1423826283-19270-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZJPbSQe+rsQDPjuNGZEBB-JKvs7yaWW9WoH0VvTCP_eUQ@mail.gmail.com>
In-reply-to: <CABBYNZJPbSQe+rsQDPjuNGZEBB-JKvs7yaWW9WoH0VvTCP_eUQ@mail.gmail.com>
Subject: RE: [PATCH] monitor/l2cap: Add log msg for read_blob_rsp
Date: Mon, 16 Feb 2015 19:14:58 +0530
Message-id: <000401d049ee$d3175470$7945fd50$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, February 16, 2015 6:00 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda; cpgs@samsung.com
> Subject: Re: [PATCH] monitor/l2cap: Add log msg for read_blob_rsp
> 
> Hi Gowtham,
> 
> On Fri, Feb 13, 2015 at 1:18 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> >> ACL Data RX: Handle 71 flags 0x02 dlen 27
> [hci0] 79.680052
> >       ATT: Read Blob Response (0x0d) len 22
> >         Part of Attribute Value:
> >         11 22 33 44 55 66 77 88 99 00 12 34 56 78 90 12  ."3DUfw....4Vx..
> >         34 56 78 90 12 34                                4Vx..4
> > ---
> >  monitor/l2cap.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/monitor/l2cap.c b/monitor/l2cap.c index 0030a4c..d58c14f
> > 100644
> > --- a/monitor/l2cap.c
> > +++ b/monitor/l2cap.c
> > @@ -2198,6 +2198,7 @@ static void att_read_blob_req(const struct
> > l2cap_frame *frame)
> >
> >  static void att_read_blob_rsp(const struct l2cap_frame *frame)  {
> > +       print_field("Part of Attribute Value:");
> >         packet_hexdump(frame->data, frame->size);  }
> >
> > --
> > 1.9.1
> 
> I would use  print_hex_field("Value", frame->data, frame->size); like in
> att_read_rsp if you really want a label.
> 

This print_hex_field() removes the junk data's as well. 
Sent v1 with the above modification. Thanks !

Regards,
Gowtham Anandha Babu
 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

