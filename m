Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8DCFA6B89B9E70418E47A2348D55495A478165D6@banasiexm01.ASIA.ROOT.PRI>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<8DCFA6B89B9E70418E47A2348D55495A478165D6@banasiexm01.ASIA.ROOT.PRI>
Date: Thu, 16 Jun 2011 10:04:53 -0400
Message-ID: <BANLkTimiLXWNfv=hwzDTMd7U8nphUSvMQg@mail.gmail.com>
Subject: Re: GATT and GATT based Profiles architecture - Query
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay Pillai <Ajay.Pillai@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Thu, Jun 16, 2011 at 3:15 AM, Ajay Pillai <Ajay.Pillai@csr.com> wrote:
> I have been reading some posts where the GATT profiles were referred to as "plugins".
>
> Could you tell me what is a "plugin" in this context?

It is a BlueZ plugin. See the plugins/ directory on BlueZ sources for
example of simple (non-GATT) plugins. There are other plugins
dedicated directories as well, run "grep -R BLUETOOTH_PLUGIN_DEFINE *"
on source to find them.

> Are these profiles running in a separate process space (to rest of BlueZ having GATT /ATT)?

Same process. They are usually builtin (statically linked with
bluetoothd binary), but can be also .so files loaded when bluetoothd
is started.

> Can these profiles be brought up and down at run time?

Not really. But they can be prevented from being started, if you pass
the -P <pluginname> option.

> Can nonstandard usecases be implemented and plugged in to use GATT from BlueZ?

If you implement your own BlueZ plugin, yes. But be sure to check the
BlueZ license, I don't know if standalone plugins would have to follow
the same license as BlueZ itself (I assume yes, as there is no
"exception" to GPL like on kernel).

> I am happy to have some code references that can show me the answer to these.

Be sure to follow the latest LE related patches which are being sent
to the list, and the ones which are going to be sent in the next days.
We are trying to submit upstream the infrastructure necessary for
implementing LE profiles ASAP. They will be probably sent as RFC, as
they add new infrastructure which we would like to get some feedback
first.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
