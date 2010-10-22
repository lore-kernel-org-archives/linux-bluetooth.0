Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Content-Type: text/plain; charset=us-ascii
Subject: (Health) ChannelConnected signal when MDL aborted?
Date: Fri, 22 Oct 2010 18:10:57 -0200
Message-Id: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com>
Cc: linux-bluetooth@vger.kernel.org
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Taking a look in the code, I saw that hdp_mcap_mdl_aborted_cb() emits a ChannelConnected signal. 

I understand that after an abort, the MDL still exists, and can be reconnected, so I understand the intention of informing the application that a channel has been "created". But I'm not sure that it is opportune.

The first thing the application will do is trying to Acquire() the channel's file descriptor (that does not exist) and that triggers a reconnection attempt, from acceptor to initiator. While the most sensible thing (in my view) is waiting for the initiator to reconnect -- if it aborted, it must have a good reason, and it will probably reject the immediate call back.

What do you think?