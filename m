Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 11:06:14 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 10/26] Bluetooth: A2MP: Process A2MP Command Reject
Message-ID: <20120412080612.GE5341@aemeltch-MOBL1>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120406232343.GG2915@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120406232343.GG2915@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Apr 06, 2012 at 08:23:43PM -0300, Gustavo Padovan wrote:
> > --- a/net/bluetooth/a2mp.c
> > +++ b/net/bluetooth/a2mp.c
> > @@ -65,6 +65,22 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
> >  	kfree(cmd);
> >  }
> >  
> > +/* Processing A2MP messages */
> > +static inline int a2mp_command_rej(struct amp_mgr *mgr, struct sk_buff *skb,
> > +				   struct a2mp_cmd *hdr)
> 
> Remove the inline, let the compiler choose it for you.

OK

> > +	struct a2mp_cmd_rej *rej = (struct a2mp_cmd_rej *) skb->data;
> > +
> > +	if (le16_to_cpu(hdr->len) < sizeof(*rej))
> 
> Isn't != better here, if I understood correctly this has a fixed size.

Actually no, it has also Data (0 or more octets):
The length and content of the Data field depends on the Reason code. If
the reason code is 0x0000 "Command not recognized" no Data field is used.

Best regards 
Andrei Emeltchenko 

