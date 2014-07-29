Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112D2F48@SHSMSX104.ccr.corp.intel.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<1405986034-29122-2-git-send-email-armansito@chromium.org>
	<3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com>
	<409335B4-82B3-40D2-970A-D39416F02591@holtmann.org>
	<CAHrH25To=NvJC+4E6U-2S5pMc1qORvKOpbG2atY9=CFn4Zwcew@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D2F48@SHSMSX104.ccr.corp.intel.com>
Date: Tue, 29 Jul 2014 12:07:24 -0700
Message-ID: <CAHrH25RkJ8x0SEx5g89496i=iWazorTpvXg7jySdUfBqMht1Pg@mail.gmail.com>
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,


> If we encounter one condition that the value is determine with the "Write=
 Command" procedure which no response for client, should we expose this kin=
d of property ? If we expose it, we have to write command to the remote and=
 read value back immediately, then emit propertychanged signal if read valu=
e equals to write value(different from old one).
>

I don't think we should expose this value until we have done an
initial read (either internally before we construct the D-Bus
hierarchy or after a call to ReadValue) or via notification. I think
we should just keep the property hidden until we know what the value
is, even in the case of a write.


> In your proposal , I think we also should read initial value from remote =
at the beginning of DBus Hierachy setup. Whatever "read", "notify", or "ind=
icate" even write request to remote, only different value compared with exi=
st cache value such as initial value, then bluez emit propertychanged signa=
l. This would be good, right?
>

I'm not opposed to this, though we can only read the initial value if
the characteristic supports reads. If the characteristic only supports
notify or indicate, then we should wait until we receive the first
notification/indication to expose the property and we keep it hidden
until then.


Cheers,
Arman
