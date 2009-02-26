Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Feb 2009 10:54:24 +0530
Message-ID: <6887eb5d0902252124s523126e3hffbc780000558b50@mail.gmail.com>
Subject: Re: About hcid.conf
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhigang Li,

Thank u very much for ur reply...

I have removed bluez-3.x from Fedora 9, but when I m installing
bluez-utils-3.36 & bluez-libs-3.36 it is installing it in
/etc/bluetooth.
Even the linkkeys are also stored in /etc/bluetooth/xx:xx:xx:xx:xx:xx/linkkeys

should I remove that also???

On 2/26/09, Li, Zhigang <zhigang.li@intel.com> wrote:
> Hi Kartikey,
>
>
>  >-----Original Message-----
>  >From: linux-bluetooth-owner@vger.kernel.org
>  >[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Kartikey Parmar
>  >Sent: 2009年2月25日 23:49
>  >To: linux-bluetooth@vger.kernel.org
>  >Subject: Abt hcid.conf
>  >
>  >hi
>  >I m modifying hcid.com lying in /etc/bluetooth for "security none"
>  >which as per hcid.conf disables security manager.
>  >So after that when I reboot my linux and then try to connect with
>  >bluetooth headset BH-209 (Nokia) it doesn't connect to it.
>  >Error is "Connection refused" which is because of no linkkey.
>  >
>  >when I disable security manager why it checks for security???
>  >Even I tried with "security auto" which reads local passkey that I
>  >have set to "0000" and my BH-209 also have default PIN "0000", still
>  >it prompts to enter passkey in bluetooth pairing & control wizard.
>  >
>  >So I m confused...exactly how can we disable security manager for
>  >simple connections?
>  >Does changes in hcid.conf make any impact?
>  >I m using bluez-4.30 on Fedora 9 (kernel 2.6.25-14)
>
>
>
>Also there is no hcid.conf in bluez-4.30 so you need remove the bluez3.x complete in your >Fc9 then install the bluez4 again.
>
>
>  >
>  >pls help me to solve this...
>  >
>  >--
>  >Kartikey Parmar
>  >R&D Software Engg
>  >Matrix Telecom Pvt Ltd
>  >Baroda, Gujarat (India)
>  >09879095390 (M)
>
> >--
>  >To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>  >the body of a message to majordomo@vger.kernel.org
>  >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
