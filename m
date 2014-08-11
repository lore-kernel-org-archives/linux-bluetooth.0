Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <B24F6699-B579-455E-8D83-9922ED923CAA@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<1405986034-29122-2-git-send-email-armansito@chromium.org>
	<3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com>
	<409335B4-82B3-40D2-970A-D39416F02591@holtmann.org>
	<CAHrH25To=NvJC+4E6U-2S5pMc1qORvKOpbG2atY9=CFn4Zwcew@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D2F48@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25RkJ8x0SEx5g89496i=iWazorTpvXg7jySdUfBqMht1Pg@mail.gmail.com>
	<CB57FC0A-030C-498D-A3E3-988BEF192ACB@holtmann.org>
	<CAHrH25TDf0OeVnD+vOjUqKB_L=bFb3+qvu3LsUZ=_CXu21Fd7w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112ECA19@SHSMSX104.ccr.corp.intel.com>
	<B24F6699-B579-455E-8D83-9922ED923CAA@holtmann.org>
Date: Mon, 11 Aug 2014 11:46:00 -0700
Message-ID: <CAHrH25SgBJSF=X+-qhFwSWjjqWHZuthHp4bFL2OXcUdTF_WWkg@mail.gmail.com>
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I have no major objections to the API, but just an API description is not enough. What is important to also deliver an implementation of this API.
>

The implementation will come in the next few months as the shared
stack takes shape. The thing is, the existing proposal is not
accompanied by an implementation (it's not even included in the
release bundles) either and it looks like there are several parties
that are implementing their own version of the API based on the
unimplemented proposal. I think it makes sense to update it with the
changes that we discussed so that people can plan their code for
future compatibility.

Either that or remove doc/gatt-api.txt entirely for the time being.

-Arman
