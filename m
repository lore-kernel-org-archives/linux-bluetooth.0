Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPGrrxVT-xugggk_CcNn_Zd+ZSJjuVPrMn64XVnNoUqK2sm60Q@mail.gmail.com>
References: <1309790985-32143-1-git-send-email-bulislaw@linux.com>
	<CABBYNZ+B_dDGRnoic6xyn4N1kRpOPTGrMJ7xBkmB7M=ZBsZzDQ@mail.gmail.com>
	<CAPGrrxVT-xugggk_CcNn_Zd+ZSJjuVPrMn64XVnNoUqK2sm60Q@mail.gmail.com>
Date: Tue, 5 Jul 2011 12:51:39 +0300
Message-ID: <CABBYNZJHkqk5dQZrYzNiVTs4Fdx8WUk70CfAzLbVHhUHWuos+Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Add SetRemoteProperty method for OOB mechanism
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Tue, Jul 5, 2011 at 11:55 AM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>
> Right, i'v discussed this approach with Johan and Szymon on freenode
> -- i'v changed few things after that (mostly because implementing it
> in AddRemoteData would break api, so i moved it to separate method) --
> maybe it would be a good idea to have this functionality now in this
> form and change it when the api break would be possible (5.0?)?
>

Apparently the idea is to use this interface is to emulate a
DeviceFound result, which I guess would make sense if the user pairs
using the bt application/agent, but in the other hand this can be
misused by application and they actually start overwriting device
properties e.g. restore tool. So the question is how much do we trust
application to provide this information without properly creating a
device? To me it sounds that we either need the agent to actually
accept this information as valid, which btw normally requires an
object path to identify the device to query its properties, or we do
it all together as I suggested in CreateDevice so we validate the
information by pairing/connecting to the device.

Btw, there is also the problem that D-Bus round trips are expensive
and with such API one have to set one by one the properties to finally
do a CreateDevice in the end, so at least the current design should
make sure that an application can set all its known properties in one
call e.g. SetRemoteProperties(string address, dict properties).

-- 
Luiz Augusto von Dentz
