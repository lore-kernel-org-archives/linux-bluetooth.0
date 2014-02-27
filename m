Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140225062656.GA3288@localhost.P-661HNU-F1>
References: <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
	<1392835893-6723-8-git-send-email-claudio.takahasi@openbossa.org>
	<20140224083344.GA29475@x220.p-661hnu-f1>
	<CAJdJm_OWfmjs2CbFxGP--nno0x5o+6R3FU5+nEP6VC7bjgNKJQ@mail.gmail.com>
	<CAJdJm_MhdZwHYuwNCJCvnfRN6DpivKLJi_hiV7icV69gFCne6Q@mail.gmail.com>
	<20140225062656.GA3288@localhost.P-661HNU-F1>
Date: Thu, 27 Feb 2014 18:47:19 -0300
Message-ID: <CAKT1EBfwx6ZVGmz0Y_MBADsRJYCeO-G6M7fZ4RSq_76dE_x6hA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 07/11] gatt: Add external services tracking
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Claudio Takahasi <CLAUDIO.TAKAHASI@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Lizardo:

On Tue, Feb 25, 2014 at 3:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Mon, Feb 24, 2014, Anderson Lizardo wrote:
>> On Mon, Feb 24, 2014 at 8:49 AM, Anderson Lizardo
>> <anderson.lizardo@openbossa.org> wrote:
>> > Hi Johan,
>> >
>> > On Mon, Feb 24, 2014 at 4:33 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> >> This whole timer thing seems too hackish to me.
>> >>
>> >> A better way to fix this might be to have something like
>> >> g_dbus_client_set_proxies_complete_watch (or some better name) to let
>> >> the code wait until GetManagedObjects has returned and the initial
>> >> proxies added. Do you agree?
>> >
>> > We came up with this workaround during development, but we forgot to
>> > highlight on the cover letter. Indeed a function like the one you
>> > propose should be enough.
>> >
>> > Regarding the name for the function, I was thinking as
>> > "g_dbus_client_proxies_ready_watch()". What do you think?
>>
>> Or "g_dbus_client_set_proxies_ready_watch()" to be consistent.
>
> That sounds good enough to me.
>
> Johan

I spent some time investigating (and prototyping) alternatives to
avoid inserting a new gdbus helper, but all of them have drawbacks.

Even using DBus properties (without object manager) extending the
RegisterService() method to include an array of the object paths in
the options doesn't help. New proxies/properties are reported
individually through callbacks, consequently extra logic is required
in the "gdbus user" to detect when all objects are "received" and to
validate each object. Another issue of using property "watch" is to
manage when it first appeared and when it is property changed.
*Maybe* foreach helper plus the "ready" callback is another acceptable approach.

Keeping the object manager approach, what we need is way to figure out
if proxy_added is reporting the "last" proxy, otherwise timer is still
needed.
So, the proposed ready callback should be called after reporting the
last proxy. I will implement the suggested helper
(g_dbus_client_set_proxies_ready_watch) and see how far we go.

Regards,
Claudio.
