Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v58=ZfoG919+N3ARNRbr6UEmoPhRKcuzfzRELa8G=9GeQ@mail.gmail.com>
References: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org>
	<CAMOw1v4h9wfcFLL-j5+fmEUNF=ShHZryw93aOC+_8d2NsbMFag@mail.gmail.com>
	<CAJdJm_NsCEmcjhtfSNh8mN5keoLzTtJsdN4+bpmdtJVzPgf4-Q@mail.gmail.com>
	<CAMOw1v58=ZfoG919+N3ARNRbr6UEmoPhRKcuzfzRELa8G=9GeQ@mail.gmail.com>
Date: Tue, 13 Nov 2012 09:02:00 -0400
Message-ID: <CAJdJm_PR=8uQOtoPUp0bqAL39LOGmUqo8w07hb-48S9XUx98Ng@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix make distcheck for input plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Nov 13, 2012 at 8:55 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>> I agree it is not the best solution. Actually, I think we can overcome
>> the problem completely by getting rid of symlinks for "drivers" (like
>> sap-{u8500,dummy}.c, suspend-dummy.c,
>> telephony-{dummy,maemo5,maemo6,ofono}.c) and having everything
>> built-in and enabled/disabled based on which D-Bus services are
>> running on the system (or, if not possible, by using config options).
>
> what do you mean by "running on the system"?

In situations where it is appropriate, we have a
g_dbus_add_service_watch() which will trigger the support code
specific for that service, instead of relying on enabling the service
support at compile time. In practice the support code will be always
compiled.

For situations where the driver code is not related to any D-Bus
service, a config option (in e.g. /etc/bluetooth/<profile>.conf) could
enable/disable the support. The main benefit here is that there will
be no "dead code" that never gets compiled because bootstrap-configure
is not able to enable all drivers.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
