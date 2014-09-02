Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] gatt api V2
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
Date: Tue, 2 Sep 2014 13:55:15 -0700
Cc: Arman Uguray <armansito@chromium.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <7926AF24-265F-454D-A502-C3554072752E@holtmann.org>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com> <CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com> <CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chao Jie,

>>>>> This patch focus on implementing the Gatt DBus API defined in
>>>>> gatt-api.txt
>>>> discussed in mailist latestly. It implement all the DBus property and
>>>> method except for array{object} of characteristics and descriptors.
>>>> Through our internal test, patche work well. I would like to contribute this
>> featrue for bluez upstream.
>>>> This first patch is just an implementation, maybe not very closely
>>>> suitable for design or put in the right file. It would be OK to modify to make more
>> sense.
>>>>> Arman, Marcel, would you like to review the patch and give some
>>>>> suggestion
>>>> for the patch? It would be great honor for me to contribute little to bluez.
>>>> 
>> 
>> Thank you for your patch. The current desire is to migrate all daemon code that uses
>> attrib/* for GATT/ATT over to the new utilities in shared/ (gatt-client, att,
>> gatt-helpers, etc.). In the end it's up to the maintainers but can we hold off on
>> implementing the D-Bus API until the shared code is ready and just do it once the
>> right way using bt_gatt_client? There are enough GAttrib dependencies inside the
>> daemon code that adding more now will just become a bigger burden in the future.
>> 
>> I recently added a set of items to the top-level TODO file regarding the new
>> GATT/ATT stack; I can talk to you more about tackling the items there.
>> 
>> Otherwise, if this is blocking people and everyone prefers to have a working GATT
>> D-Bus API sooner than that, then I suggest not putting all of the code in src/device.c.
>> You should probably abstract that away in a separate module (such as a
>> src/gatt-client) and have device.c initialize it. Also, please break this down into
>> multiple smaller patches as Luiz suggested.
> 
> I have noticed that you are focusing on the Gatt shared library development in maillist 
> latestly. And there is always a question in mind that no opportunity to ask you , why we
> replace old GATT/ATT by new Gatt shared library? 
> 
> According to your advice , I saw the gatt TODO list items including gatt-api.txt part.
> Of course, new Gatt DBus API will based on shared/gatt-client. But I believe most logical
> would be common except for API from shared/gatt-client.
> 
> There is no problem holding on until the shared code is ready, we can use old base and internal
> patch to transition.
> 
> I saw a lot of TODO List in GATT/ATT part, and gatt-api.txt base on new shared library. So I will
> pay more attention to shared library code. Sometimes I am not sure your work plan which items
> will do first, which not. So if any help I can do or wrong patches I submitted, just talk to me, 
> I would appreciate it.

we want to create a common base for GATT and ATT internally. Common means that it is used by internal tools, the upstream bluetoothd and also the bluetoothd variation that we use for Android.

At the same time we are removing all dependencies on GLib from the codebase. Which means I am pretty much against in accepting new code that explicitly relies on GLib for its IO handling or certain data structures.

So my advise is that you help us get the new code ready. The more people helping here, the faster it gets. Arman has done an excellent job in getting this off the ground and creating TODO entries.

Regards

Marcel

