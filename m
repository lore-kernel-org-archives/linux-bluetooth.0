Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CB57FC0A-030C-498D-A3E3-988BEF192ACB@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<1405986034-29122-2-git-send-email-armansito@chromium.org>
	<3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com>
	<409335B4-82B3-40D2-970A-D39416F02591@holtmann.org>
	<CAHrH25To=NvJC+4E6U-2S5pMc1qORvKOpbG2atY9=CFn4Zwcew@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D2F48@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25RkJ8x0SEx5g89496i=iWazorTpvXg7jySdUfBqMht1Pg@mail.gmail.com>
	<CB57FC0A-030C-498D-A3E3-988BEF192ACB@holtmann.org>
Date: Thu, 31 Jul 2014 20:11:23 -0700
Message-ID: <CAHrH25TDf0OeVnD+vOjUqKB_L=bFb3+qvu3LsUZ=_CXu21Fd7w@mail.gmail.com>
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I think this all makes sense and the API is in a reasonable shape now.
All of the properties/methods can integrate nicely with client and
server implementations (with one or two properties being optional for
server). I think we can revisit GattManager1 once we start thinking
about the server code but for now I think this is good for client.
And, of course, we can always add new properties/methods later.
