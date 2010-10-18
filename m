Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] bluetooth: Remove some unnecessary error messages
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <1284659895-27984-2-git-send-email-mjg@redhat.com>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com>
	 <1284659895-27984-2-git-send-email-mjg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Oct 2010 13:55:17 +0200
Message-ID: <1287402917.3316.128.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthew,

> The main reason for these urbs to error out on submission is that runtime
> pm has kicked in, which is unnecessary noise. Let's just drop them.

do we wanna remove them or just turn into BT_DBG which is under dynamic
debug control. Or do we have a set of error results that we do wanna
print and others that we wanna ignore?

Regards

Marcel


