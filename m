Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Sep 2012 12:28:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mgmt: Implement support for passkey
 notification
Message-ID: <20120905092824.GA25573@x220>
References: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
 <1346833772.21200.79.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346833772.21200.79.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Sep 05, 2012, Marcel Holtmann wrote:
> Hi Johan,
> 
> > This patch adds support for Secure Simple Pairing with devices that have
> > KeyboardOnly as their IO capability. Such devices will cause a passkey
> > notification on our side and optionally also keypress notifications.
> > Without this patch some keyboards cannot be paired using the mgmt
> > interface.
> 
> can we see a mgmt-api.txt documentation patch as RFC first.

Actually I already pushed that yesterday. We can still change it of
course if you have improvement suggestions:

+Passkey Notify Event
+====================
+
+Event Code             0x0017
+Controller Index       <controller id>
+Event Parameters       Address (6 Octets)
+                       Address_Type (1 Octet)
+                       Passkey (4 Octets)
+                       Entered (1 Octet)

And yes, I know some description for the event (and most other events in
mgmt-api.txt) would be good.

Johan
