Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112F7F7A@SHSMSX104.ccr.corp.intel.com>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
	<7926AF24-265F-454D-A502-C3554072752E@holtmann.org>
	<CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F7F7A@SHSMSX104.ccr.corp.intel.com>
Date: Wed, 3 Sep 2014 07:49:22 -0700
Message-ID: <CAHrH25QHuLFhVcYFMnHfGH4g5SHRyW65-V6gZ5SyPYWGsELmMw@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chao Jie,


> I take some time delved in shared/* files, although I cannot take a look at code line
> one by one in short time,, the whole stack appear clear to me help work on this.
> When I use the btgatt-client tool to connect LE device today, I get a problem as belows:
> ./btgatt-client -i hci0 -d DA:3E:9D:65:75:BE
> Connecting to device ... Failed to connect: Operation now in progress.
> I used bluetoothctrl to connect the LE device , it's ok.
> I compared btgatt-client l2cap connect process to setup socket parameter with bluetoothd
> did, the process of setting socket configuration seems to be the same.
> What details did I forget to do to result in this problem? Did you encounter on this issue?
>

Make sure to stop bluetoothd if you haven't. You might have a race for
the connection there. If that doesn't help, you probably need to debug
things a bit further.


> Maybe the mail title does not include "signed write" key word, can you tell me about
> which month in that discussion came out ?
>

Looks like the subject was: "[PATCH v3 1/4] src/shared/att: Introduce
struct bt_att." We basically talked about the need for bt_att to
somehow obtain the CSRK (through bt_att_new maybe?) and internally
keep the local+remote sign counters to be able to calculate the
authentication signature. Basically, the authentication signature
should get calculated by bt_att given all the data that it needs.


> I agree that there are too many dependency on GArrtib now, it's a difficult migration
> work. You said probing interface for GATT that is not very clear to me. For my understanding,
> although plugin won't perform service discovery any more, they can tranverse the service_list
> in the bt_gatt_client structure. So for plugins, they only need the bt_gatt_client structure
> created once device connected.
>

Yes, exactly. We will probably have device a ready callback in
device.c (look at bt_gatt_client_set_ready_handler), which will be
called once all discovery has been completed. From there, device.c can
just probe each profile/plugin based on the discovered services. The
plugins would have access to the bt_gatt_client instance so that they
can iterate through services, characteristics, etc. Basically
bt_gatt_client acts as the client attribute cache.


Thanks,
Arman
