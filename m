Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1108100942580.25878@mathewm-linux>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
	<alpine.DEB.2.02.1108040901420.13578@mathewm-linux>
	<1312499377.2158.36.camel@THOR>
	<20110805191210.GA2537@joana>
	<alpine.DEB.2.02.1108081628030.29183@mathewm-linux>
	<20110809043210.GA2594@joana>
	<alpine.DEB.2.02.1108100942580.25878@mathewm-linux>
Date: Wed, 10 Aug 2011 21:16:29 +0300
Message-ID: <CABBYNZKH4Ce1P6MSY9Nsz_Xf4+EQF5zs4dRo1VHhSoEWjWTnbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	Peter Hurley <peter@hurleysoftware.com>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Aug 10, 2011 at 8:38 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
>> +struct hci_chan {
>> +       struct list_head list;
>> +       struct hci_conn *conn;
>> +       struct sk_buff_head data_q;
>> +       unsigned int    sent;
>> +}
>
> At the BlueZ summit last year, the group settled on using an "HCI channel"
> as an abstraction for AMP logical links.  We have a hci_chan struct already
> that you could add to.  Before making changes to HCI data structures, could
> we first work on upstreaming the AMP HCI changes (which also include some
> QoS-related code)?

If just you told us this before I would have not spend time
implementing it, so could you please sent this patches ASAP, otherwise
I will just send mine that just address the prioritization

Btw, the thread intent is perhaps becoming too broad,  we should focus
in small steps lets say first HCI Channel, then we continue from
there.

-- 
Luiz Augusto von Dentz
