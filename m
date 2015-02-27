Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25TOMVFwAJ23KQDkrRugpihTK+1ijm9RSzE0gkzjxBA3nA@mail.gmail.com>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
	<1424927610-26226-4-git-send-email-armansito@chromium.org>
	<938707CA-DE91-41D5-B611-B89CFF9236C6@holtmann.org>
	<CAHrH25TOMVFwAJ23KQDkrRugpihTK+1ijm9RSzE0gkzjxBA3nA@mail.gmail.com>
Date: Fri, 27 Feb 2015 08:47:56 +0200
Message-ID: <CABBYNZLA-krR1iM-J9szbHDa7osgp9ZPWFYcxyAUc13SqnMZfw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 03/17] gdbus/client: Allow specifying
 ObjectManager path
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Feb 26, 2015 at 10:32 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Marcel,
>
>> On Thu, Feb 26, 2015 at 7:38 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Arman,
>>
>>> GDBusClient currently hard-codes "/" as the remote ObjectManager path.
>>> This is generally incorrect, as an application can choose to expose an
>>> ObjectManager at any well-known path. This patch fixes this by allowing
>>> the user to pass in the ObjectManager path to g_dbus_client_new.
>>> ---
>>> client/main.c            |  2 +-
>>> gdbus/client.c           | 23 ++++++++++++++++-------
>>> gdbus/gdbus.h            |  5 +++--
>>> plugins/hostname.c       |  2 +-
>>> profiles/iap/main.c      |  2 +-
>>> tools/bluetooth-player.c |  2 +-
>>> tools/gap-tester.c       |  3 ++-
>>> tools/gatt-service.c     |  2 +-
>>> tools/mpris-proxy.c      |  2 +-
>>> tools/obexctl.c          |  2 +-
>>> unit/test-gdbus-client.c | 39 ++++++++++++++++++++++++++-------------
>>> 11 files changed, 54 insertions(+), 30 deletions(-)
>>
>> please to not intermix gdbus/ changes with others. Everything in gdbus/ needs to be a separate patch. You are affecting more than one project here.
>>
>
> This is a gdbus/ only change but I it changes an API definition so all
> of these other spots need to be updated otherwise the code won't
> compile.

I wonder if we really need this change or we should have a different
function. e.g. g_dbus_client_new_full where we can include the object
manager path without breaking backward compatibility.


-- 
Luiz Augusto von Dentz
