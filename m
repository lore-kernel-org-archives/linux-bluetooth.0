Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=vMJDDtJkpZPQY+MijXLA8MuLhSQ@mail.gmail.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<8DCFA6B89B9E70418E47A2348D55495A478165D6@banasiexm01.ASIA.ROOT.PRI>
	<BANLkTimiLXWNfv=hwzDTMd7U8nphUSvMQg@mail.gmail.com>
	<8DCFA6B89B9E70418E47A2348D55495A4781711C@banasiexm01.ASIA.ROOT.PRI>
	<BANLkTimXg6_3f25sXCtZ_YU3VoWUayqbFQ@mail.gmail.com>
	<BANLkTi=vMJDDtJkpZPQY+MijXLA8MuLhSQ@mail.gmail.com>
Date: Fri, 17 Jun 2011 08:39:50 -0400
Message-ID: <BANLkTim6_8rrQP_2Z+w_h6F2O8Z_2S-P9Q@mail.gmail.com>
Subject: Re: GATT and GATT based Profiles architecture - Query
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: Ajay Pillai <Ajay.Pillai@csr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jun 17, 2011 at 8:22 AM, Santiago Carot <sancane@gmail.com> wrote:
> Just a note. If there is a full GATT API and we do BlueZ plugins over
> GATT (wich have their own D-Bus API as usual in BlueZ). The GATT API
> may be in conflict with those APIs exposed by those plugins because
> Applications will be able to use Attribute D-Bus one avoiding those
> APIs exposed by plugins. Do not?

As long as all APIs use the same stack, there is no issue AFAIK. For
instance, if someone uses the Proximity D-Bus API and another
application does the same operation over the "generic" Attribute API,
both operations will be processed the same way inside the BlueZ GATT
stack (because they use the same functions internally). At least this
is the intended behavior, we don't do much testing like that :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
