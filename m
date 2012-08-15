Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 01:27:27 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ] doc: Introduce Alert API
Message-ID: <20120815042727.GE3344@joana>
References: <1344450186-14961-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344450186-14961-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2012-08-08 14:23:06 -0400]:

> This API will be implemented and initially used by Phone Alert Status
> and Alert Notification GATT profiles (server role).
> ---
>  doc/alert-api.txt |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 doc/alert-api.txt
> 
> diff --git a/doc/alert-api.txt b/doc/alert-api.txt
> new file mode 100644
> index 0000000..209c4da
> --- /dev/null
> +++ b/doc/alert-api.txt
> @@ -0,0 +1,95 @@
> +BlueZ D-Bus Alert API description
> +*********************************
> +
> +Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
> +
> +Introduction
> +------------
> +
> +Currently, there are two different GATT server profiles that depend on
> +receiving alerts or notifications from the platform: Phone Alert Status (PASP)
> +and Alert Notification (ANP). Additionally, PASP is very specific to mobile
> +phones, and also allow limited control to alerts (i.e. mute once, or switch to
> +a silent mode).
> +
> +This document presents a unified API that allows to register, 

Is there some missing text here?

> +
> +Alert hierarchy
> +===============
> +
> +Service		org.bluez
> +Interface	org.bluez.Alert
> +Object path	/org/bluez
> +
> +Methods		void RegisterAlert(string category)
> +
> +			Register a new alert category. This means the
> +			application will be responsible for notifying BlueZ of
> +			any alerts of that category, using the Alert() method.
> +
> +			Supported categories: generic, email, news, call,
> +			missed_call, sms_mms, voice_mail, schedule,
> +			instant_message, ringer, vibrate, display.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		void RegisterAgent(string category, object agent)
> +
> +			Register a new agent for the alert category. The agent
> +			object methods to be called depend on the category. The
> +			currently supported category is "ringer", with methods
> +			MuteOnce() and SetRingerMode().
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments

If I got this right you RegisterAlert() and then RegisterAgent() in the
sequence, right? Why can't you merge both calls into one.

> +
> +		void NewAlert(string category, string description)
> +
> +			Notify BlueZ of a new alert for the given category. The
> +			description can be sender name, called ID, title, or
> +			other information specific to the alert. For ringer,
> +			vibrate and display categories, valid descriptions are
> +			"active" and "not active".

The way I understand it I see many NewAlert() calls happening almost at the
same time. Isn't possible to pass a dict with many {string category, string
description} inside?

> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		void UnreadAlertCount(string category, uint16 count)
> +
> +			Some services (like SMS and e-mail) keep track of
> +			number of unread items. This method allows to update
> +			this counter, so peer devices can read it using Alert
> +			Notification Profile.
> +
> +			Note that just calling NewAlert() will not implicitly
> +			increment the unread count for a category. The
> +			application must call this method to increase or
> +			decrease the unread counter.

Is there a good reason for not increment the count on NewAlert()?

	Gustavo
