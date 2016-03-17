Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+FYuUp+Bt-BKs96U04HF-kw1ugvujPSCpvgVzdh3wH8A@mail.gmail.com>
References: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com>
	<CABBYNZLzhTX8rJOzadn0+-WM1+Rr5WZvqQPFtzu46EyFEpj_yg@mail.gmail.com>
	<DE03A908-C3D3-4467-AB9F-3CD11C2539C7@gmail.com>
	<CABBYNZKCr53JJGVjPq65_aH8vp3LfCpymPmPPpZ_NwPosWFHSA@mail.gmail.com>
	<48839EC2-6A8E-4110-8224-229ACCAC5854@gmail.com>
	<CABBYNZK1G+M-ge+XdBGpwKXw+w6Hau4E3Xc+-KyMr7BDRL1-ug@mail.gmail.com>
	<55A7F9E2-32E1-4618-8E8A-CEC75F464025@gmail.com>
	<CABBYNZLEvn4Gw2=ukc8o+WZoaQ13FZSm5cX3xoczGC2D5g1Y0g@mail.gmail.com>
	<CABBYNZJxdzs620LZCAqSEuC4p3goa1=m=Jmh2erxY66NmDFoVg@mail.gmail.com>
	<C3C308DE-48EE-4A57-8CC7-7B230D0BF6D8@gmail.com>
	<CABBYNZ+FYuUp+Bt-BKs96U04HF-kw1ugvujPSCpvgVzdh3wH8A@mail.gmail.com>
Date: Thu, 17 Mar 2016 13:22:59 +0200
Message-ID: <CABBYNZ+D5NcZUQQ+RjM1HK5Dp5KB0V7Q3qeh8JWnCSgy4Lw++Q@mail.gmail.com>
Subject: Re: No Connected=false event on iPhone app kill.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tonis,

On Thu, Mar 17, 2016 at 1:20 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

>> I tried the patches and they did not seem to work unfortunately.
>>
>> here are the valgrind and btmon logs:
>> patch 1: http://pastebin.com/raw/pKbLtBAw
>> patch 2: http://pastebin.com/raw/sW68M3vK

Btw, if you are seeing gatt_client_remove_all_notify_in_range in the
trace that is probably because the version you are running is not
patched as the first patch removes it, so something is not right with
your setup.

>> Since this is the first time for me to apply patches, maybe its good to verify my patching/building process?
>>
>> $ git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git
>> $ checkout 5.37 commit
>
> No need to checkou 5.37, we want to check the result using the
> upstream version so it can be added to 5.38
>
>>
>> store the 2 patches in .patch files
>>
>> $ git apply patch1.patch
>
> This is correct.
>
>> rebuild the blueZ with:
>>
>> $ ./configure --enable-experimental && make
>> $ make install && ln -svf ../libexec/bluetooth/bluetoothd /usr/sbin
>> $ install -v -dm755 /etc/bluetooth && install -v -m644 src/main.conf /etc/bluetooth/main.conf
>>
>> run the bluetooth again
>> $ sudo /usr/sbin/bluetoothd -E -d
>>
>> verify that it still crashes and try to apply the patch2 as well (without cloning the repo again e.g keeping the patch1 changes)
>
> Just apply the 2 together, and take a look at HACKING how to build and
> run from the source tree since you probably don't want to replace the
> BlueZ that is coming with your distro.



-- 
Luiz Augusto von Dentz
