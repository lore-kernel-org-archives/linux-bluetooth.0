Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121003082118.GA12607@x220>
References: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
	<1349209490-31830-1-git-send-email-anderson.lizardo@openbossa.org>
	<1349209490-31830-2-git-send-email-anderson.lizardo@openbossa.org>
	<20121003082118.GA12607@x220>
Date: Wed, 3 Oct 2012 06:56:46 -0400
Message-ID: <CAJdJm_OZ8mVDxpOYDq6pZNyYUVMhT0mmOxqzPHOqgAvRSCdqwg@mail.gmail.com>
Subject: Re: [PATCH v3 BlueZ 01/27] doc: Introduce Alert API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Oct 3, 2012 at 4:21 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Tue, Oct 02, 2012, Anderson Lizardo wrote:
>> +             void SetRinger(string mode)
>> +
>> +                     This method is only called if "ringer" alert category
>> +                     is specified when registering the agent.
>> +
>> +                     Set ringer to the specified mode. If mode is "enabled",
>> +                     ringer is set to the default mode, as defined by the
>> +                     current active profile. If mode is "disabled", ringer
>> +                     will not activate on incoming calls, until it is set
>> +                     back to "enabled" mode.
>> +
>> +                     Possible Errors: org.bluez.Error.InvalidArguments
>
> Since you've used a string here instead of a boolean is it correct to
> assume that you want to maintain the capability of extending the
> possible values to more than just "enabled" and "disabled"?

Yes, the idea here was to be able to extend this in case any future
GATT profile intends to control the ringer (or phone profile) to other
values.

> Does the
> current profile/service specification already proved more possibilities
> than these two values?

The Phone Alert Status (PASP) spec defines only "normal" and "silent"
modes (the other modes are Reserved). We mapped them to
"enabled/disabled" so it is more consistent with the Alert
Notification Profile (which is sharing the same D-Bus API). As PASP
only controls the ringer, it seemed logical to simply map it into the
broader ANP (which has the concept of "alert categories"). So we
created this "ringer" category and use it for PASP functionality
(along "display" and "vibrate").

See the description for RegisterAlert() and NewAlert() for more
details on how these categories work. Besides the ringer, the PASP
profile notifies state changes for the vibration motor and display
(which are mapped to "active"/"not active" alerts on the NewAlert()
API).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
