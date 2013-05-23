Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ0fi6LHBMyj1OZ=ZEtfXUkrPB5_7c_MBD-zRBvoa4MmQ@mail.gmail.com>
References: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
 <CABBYNZ+1baqBJRNgY9a_4soZ5o3oWK_jfSv=7RqMAkJtz=BP7w@mail.gmail.com>
 <CABBYNZJA0C2r-4Y=fd6V_g115ZHyDxmN=9vUCE=HYepMncWKVQ@mail.gmail.com>
 <CAGd9gwhAfcc_DVdJxZ7rqyKPji6xy51TGtPuCvEPET_JK4NJjg@mail.gmail.com>
 <CABBYNZKxTjvbL5Oww3Xni6WzUK3RqBzK7pcMLFSrF919FCBg=g@mail.gmail.com>
 <CAGd9gwgN8KkhCNFTKdE+=YUOAPgV35vGdiSc_GX312+MtbMcdA@mail.gmail.com> <CABBYNZJ0fi6LHBMyj1OZ=ZEtfXUkrPB5_7c_MBD-zRBvoa4MmQ@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 23 May 2013 15:46:11 -0700
Message-ID: <CAGd9gwjk=UMdS6g1EL=XrKrL2HYmJci--Z=VNzAM_qM2yztNSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 0/4] AVRCP connection-tracking issues
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 23, 2013 at 2:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>>> So with what patch-set have you tested, mine that Ive send a few hours
>>> ago or Mikel's?
>>
>> I tried Mikel's patchset. I can try your patchset now if you want.
>
> Please do it, Ive done some testing with the devices I have with me
> (Sony MW600 and a couple phones for the CT role) and it seems to fix
> the problem. It is not that Mikel's patches wouldn't work, they
> actually do fix it too but it fix the effect not the cause that is
> connecting the wrong profile in first place.

Ok, I tried your patch in the same environment as before and the logs
are here ( http://ix.io/5LR ).
That one also works fine:
* the device is idle and would accept a connection from the host.
* pressing the bluetooth logo button makes it leave that mode and
start a connection to the host... but it takes some time to do that
(about 2sec).
* a "connect" command in the bluetoothctl will fail and (now) return an error.
* the "ongoing" connection from the device succeeds after that and
everything works :)

Thank you!
Alex.
