Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Some kernel changes
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org,
	ext Nick Pelly <npelly@google.com>, johan.hedberg@nokia.com
In-Reply-To: <496895AB.4050902@nokia.com>
References: <496895AB.4050902@nokia.com>
Content-Type: text/plain
Date: Mon, 12 Jan 2009 14:53:33 +0100
Message-Id: <1231768413.23749.1.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

> Here is set of unclean patches for discussion. These are still untested 
> and contain issues, but I would like to know if we should continue with 
> these or change something radically. Also commit messages are somewhat 
> misleading in some places.
> 
> Basically idea is to implement connection rejection support for l2cap 
> and rfcomm sockets. IOW possibility to check initiator bd-address and 
> ask for authorization before accepting connection.
> 
> Other goal is to fix encryption and authentication levels to fulfill 2.1 
> requirements.

so I pushed my re-worked and pending patches to bluetooth-testing.git
now. This adds support for BT_DEFER_SETUP and BT_SECURITY (only the
logic and not the actual socket option).

Regards

Marcel


