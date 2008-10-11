Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add OUI check for the PS3 BD remote
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1223679525.4397.18.camel@californication>
References: <1223652739.22125.3.camel@snoogens.fab.redhat.com>
	 <1223679525.4397.18.camel@californication>
Content-Type: text/plain
Date: Sat, 11 Oct 2008 01:16:46 +0100
Message-Id: <1223684206.3104.57.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2008-10-11 at 00:58 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> the patch has been applied, but != FALSE is also == TRUE. We don't need
> double negation ;)

Actually. FALSE is defined as "0", and TRUE as "!FALSE". So depending on
the system and the compiler, TRUE could be anything, including 1, just
not 0.
