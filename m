Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add OUI check for the PS3 BD remote
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1223652739.22125.3.camel@snoogens.fab.redhat.com>
References: <1223652739.22125.3.camel@snoogens.fab.redhat.com>
Content-Type: text/plain
Date: Sat, 11 Oct 2008 00:58:45 +0200
Message-Id: <1223679525.4397.18.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

the patch has been applied, but != FALSE is also == TRUE. We don't need
double negation ;)

regards

Marcel


