Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
Date: Sun, 21 Jun 2009 11:08:53 -0300
Message-ID: <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
Subject: Re: regression introduced on v2.6.30-rc1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Finally find out what is the problem, we are currently sending DM to
reject the connection when using DEFER_SETUP which is fine according
to RFCOMM spec:

"the responding implementation may replace the "proper" response on
the Multiplexer Control channel with a DM frame, sent on the referenced DLCI
to indicate that the DLCI is not open, and that the responder would not grant a
request to open it later either."

What it doesn't mention is which part is supposed to take down DLCI 0
in case that there is no other DLC configured, from what I could find
out the initiator is supposed to take down by sending DISC 0. This
seems to work fine when using rctest, but some headset may not take
any action when receiving the DM frame, so what can be done in this
case?

What about a timeout to trigger rfcomm_session_put and send DISC 0?
This might solve the problem and we avoid the double DISC 0 in case
the initiator stack implementation cope with DM.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
