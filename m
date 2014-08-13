Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112F0DB2@SHSMSX104.ccr.corp.intel.com>
References: <1407789427-7118-1-git-send-email-armansito@chromium.org>
	<1407789427-7118-2-git-send-email-armansito@chromium.org>
	<3D02B219753AD44CBDDDE484323B1774112F0DB2@SHSMSX104.ccr.corp.intel.com>
Date: Wed, 13 Aug 2014 10:45:23 -0700
Message-ID: <CAHrH25QHpf0tjD2YaNvAOzMvSOPc_CcixMpoJ4Lx6MThJf_43Q@mail.gmail.com>
Subject: Re: [RFC v2 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

> Following your new proposal to implement, there is one details that I missed before which condition the services would set up under the local remote device. I think this "optional" maybe is not essential. Gatt Hiearchy should always set up when it connected to remote devices.
>

I marked it as optional since it only applies when BlueZ is the
central. If BlueZ is acting as a server for services that are
registered through GattManager1, then this property doesn't make much
sense. Even though the server-side implementation won't happen for
some time, the idea is that server and client D-Bus APIs will use the
same interface definitions.

Thanks,
Arman
