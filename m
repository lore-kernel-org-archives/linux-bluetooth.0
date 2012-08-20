Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120818182459.GB30527@echo>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1345272662-2850-9-git-send-email-lucas.demarchi@profusion.mobi>
	<20120818182459.GB30527@echo>
Date: Mon, 20 Aug 2012 10:12:53 +0300
Message-ID: <CABBYNZK=3ddQk7zofGUtyV+oxA_i3cZa9qCCYS3oYVEuXNZadg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 08/15] gdbus: Add support for org.freedesktop.DBus.ObjectManager
 interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Sat, Aug 18, 2012 at 9:25 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:

>>  static const GDBusMethodTable introspect_methods[] = {
>> @@ -617,6 +655,7 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
>>               return NULL;
>>
>>       dbus_message_iter_init_append(reply, &iter);
>> +
>
> The code looks a little better without this extra line.

It is now fixed in my repository:
https://gitorious.org/~vudentz/bluez/vudentzs-clone/commit/266200c548467c8eac785b3eba91afcd2bc244f9?format=patch

@Lucas: Please rebase

-- 
Luiz Augusto von Dentz
