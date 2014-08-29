Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
Date: Fri, 29 Aug 2014 07:29:46 -0700
Message-ID: <CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holmann.org" <marcel@holmann.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,


>> > This patch focus on implementing the Gatt DBus API defined in gatt-api.txt
>> discussed in mailist latestly. It implement all the DBus property and method
>> except for array{object} of characteristics and descriptors. Through our internal
>> test, patche work well. I would like to contribute this featrue for bluez upstream.
>> This first patch is just an implementation, maybe not very closely suitable for
>> design or put in the right file. It would be OK to modify to make more sense.
>> > Arman, Marcel, would you like to review the patch and give some suggestion
>> for the patch? It would be great honor for me to contribute little to bluez.
>>

Thank you for your patch. The current desire is to migrate all daemon
code that uses attrib/* for GATT/ATT over to the new utilities in
shared/ (gatt-client, att, gatt-helpers, etc.). In the end it's up to
the maintainers but can we hold off on implementing the D-Bus API
until the shared code is ready and just do it once the right way using
bt_gatt_client? There are enough GAttrib dependencies inside the
daemon code that adding more now will just become a bigger burden in
the future.

I recently added a set of items to the top-level TODO file regarding
the new GATT/ATT stack; I can talk to you more about tackling the
items there.

Otherwise, if this is blocking people and everyone prefers to have a
working GATT D-Bus API sooner than that, then I suggest not putting
all of the code in src/device.c. You should probably abstract that
away in a separate module (such as a src/gatt-client) and have
device.c initialize it. Also, please break this down into multiple
smaller patches as Luiz suggested.

Thanks,
Arman
