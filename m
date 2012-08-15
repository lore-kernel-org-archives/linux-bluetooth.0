Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120815042727.GE3344@joana>
References: <1344450186-14961-1-git-send-email-anderson.lizardo@openbossa.org>
	<20120815042727.GE3344@joana>
Date: Wed, 15 Aug 2012 09:01:10 -0400
Message-ID: <CAJdJm_PrkwFdvDaq-6m5KkuJXmhfR65KLHxhry2rLiXCY2DFoA@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc: Introduce Alert API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Aug 15, 2012 at 12:27 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
>> +Currently, there are two different GATT server profiles that depend on
>> +receiving alerts or notifications from the platform: Phone Alert Status (PASP)
>> +and Alert Notification (ANP). Additionally, PASP is very specific to mobile
>> +phones, and also allow limited control to alerts (i.e. mute once, or switch to
>> +a silent mode).
>> +
>> +This document presents a unified API that allows to register,
>
> Is there some missing text here?

Yes, I will fill the missing text on next revision. I also have minor
fixes to the alert categories.

>> +
>> +Alert hierarchy
>> +===============
>> +
>> +Service              org.bluez
>> +Interface    org.bluez.Alert
>> +Object path  /org/bluez
>> +
>> +Methods              void RegisterAlert(string category)
>> +
>> +                     Register a new alert category. This means the
>> +                     application will be responsible for notifying BlueZ of
>> +                     any alerts of that category, using the Alert() method.
>> +
>> +                     Supported categories: generic, email, news, call,
>> +                     missed_call, sms_mms, voice_mail, schedule,
>> +                     instant_message, ringer, vibrate, display.
>> +
>> +                     Possible Errors: org.bluez.Error.InvalidArguments
>> +
>> +             void RegisterAgent(string category, object agent)
>> +
>> +                     Register a new agent for the alert category. The agent
>> +                     object methods to be called depend on the category. The
>> +                     currently supported category is "ringer", with methods
>> +                     MuteOnce() and SetRingerMode().
>> +
>> +                     Possible Errors: org.bluez.Error.InvalidArguments
>
> If I got this right you RegisterAlert() and then RegisterAgent() in the
> sequence, right? Why can't you merge both calls into one.

Originally, the agent was only necessary for the "ringer" category.
But after further thinking, looks like we can use it to update the
"new alert" and "unread alert" counts necessary for ANP. I will
prepare an updated document and send ASAP.

>> +
>> +             void NewAlert(string category, string description)
>> +
>> +                     Notify BlueZ of a new alert for the given category. The
>> +                     description can be sender name, called ID, title, or
>> +                     other information specific to the alert. For ringer,
>> +                     vibrate and display categories, valid descriptions are
>> +                     "active" and "not active".
>
> The way I understand it I see many NewAlert() calls happening almost at the
> same time. Isn't possible to pass a dict with many {string category, string
> description} inside?

It is not clear from the description above (I will improve it), but
for categories like "email" that can have many messages received after
a sync, only a single NewAlert() call is made. The description is for
the last e-mail sent. So the event is actually a single one: "you got
N e-mails, and the sender for the last one is ...". The same applies
to any alerts which have multiple items.

>
>> +
>> +                     Possible Errors: org.bluez.Error.InvalidArguments
>> +
>> +             void UnreadAlertCount(string category, uint16 count)
>> +
>> +                     Some services (like SMS and e-mail) keep track of
>> +                     number of unread items. This method allows to update
>> +                     this counter, so peer devices can read it using Alert
>> +                     Notification Profile.
>> +
>> +                     Note that just calling NewAlert() will not implicitly
>> +                     increment the unread count for a category. The
>> +                     application must call this method to increase or
>> +                     decrease the unread counter.
>
> Is there a good reason for not increment the count on NewAlert()?

There are two counts supported by the ANP profile: "Unread Alert
count" and "New Alert count". I'll try to explain here, but I
suggesting reading sections 1.7.2, 1.7.3, 4.1.2 and 4.1.3 from
ANS_SPEC_V10.pdf. These counts are per category.

Unread Alert count is only useful to some categories, like SMS and
e-mail, that have the concept of "unread message". It may
increase/decrease depending on user interaction with the host UI (e.g.
marking messages as read/unread, deleting messages etc.)

New Alert count is used to keep track of how many alerts are not yet
acknowledged by the user. It is also applicable to SMS/email, and all
other categories. E.g. two calendar events on the same day, and none
of them were opened by the user, will increase this count by two.

As mentioned above, we can use the zgent to have better tracking of
these counts. This would avoid the need for this method, and instead
BlueZ could request for the up-to-date alert counts from the e-mail
application (for example). I will send soon a v2 of this document.


Thanks for your comments!

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
