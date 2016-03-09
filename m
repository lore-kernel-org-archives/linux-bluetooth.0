Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJnkazKAD-c4EWrx-schmHTkb1Qumq1LVcQMG7iq_8PoA@mail.gmail.com>
References: <CAEZxfGPvzMVj++anQKY_6RREvmyT-vBnWqYpRiHJVvKKKb3YsQ@mail.gmail.com>
	<CABBYNZK35diyf=VMGikSJ79+qR=8F5adLt=ddkaOPv3f2x-Ksg@mail.gmail.com>
	<CAEZxfGPZOj+uHQde5Lzb3G9HyF-vvDR8R29BatccKkOMkcwGSg@mail.gmail.com>
	<CAEZxfGN7-kDF6GzLYpx0tsXXiEnq1W2zCVEo2am9PX8a7Hdm=w@mail.gmail.com>
	<CAEZxfGM7mpnCP8tM9Mr1OR3EVG_0RoNCCrR+Wv593E0ZQCNM7g@mail.gmail.com>
	<CABBYNZJnkazKAD-c4EWrx-schmHTkb1Qumq1LVcQMG7iq_8PoA@mail.gmail.com>
Date: Wed, 9 Mar 2016 12:53:04 +0200
Message-ID: <CABBYNZJ_6z6Mym2o2L8Vx3fGqv62Rf3d=T51rYJLEcoTvj6OdA@mail.gmail.com>
Subject: Re: Write should return error if device is disconnected while
 expecting a response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Mon, Mar 7, 2016 at 5:54 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi François,
>
> On Mon, Mar 7, 2016 at 5:36 PM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> (gentle ping)
>>
>> On Thu, Mar 3, 2016 at 10:46 AM, François Beaufort
>> <beaufort.francois@gmail.com> wrote:
>>> Since I'm expecting a response and device gets disconnected, I should
>>> get a write error don't you think?
>
> Yes, it should probably return and error so the client is not left
> hanging. I will investigate how this can be fixed.

This should be fixed upstream, it will be part of 5.38 which should be
coming out soon.

-- 
Luiz Augusto von Dentz
