Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
Date: Tue, 2 Sep 2014 13:27:28 -0700
Message-ID: <CAHrH25Rid1406pRUPMKtZ-7tF0uu8YV-g0JuRWokDFgyBCdukQ@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

The idea is to create a set of tools that can be shared among
different platform implementations (desktop, Android, etc.) without
direct library dependencies, such as glib. GAttrib is written in a way
that directly interacts with GIOChannel whereas the shared stuff use
shared/io, which is a simple abstraction that is compatible with
GIOChannel and Glib mainloop, as well as BlueZ's own mainloop
implementation (monitor/mainloop.c).

Beyond removing the dependency issue, the shared code will provide a
stand-alone, functioning GATT server/client implementation that is not
tied to any daemon code. The idea is that you can instantiate a struct
bt_gatt_client, and that will do all the attribute discovery and
caching for you. The upper-layer won't need to know about the contents
of ATT protocol PDUs or explicit handling of "service changed"
indications, etc (similarly, there will be a shared/gatt-server to
handle all the GATT server magic).

Others can comment more on this, since I've been basically following
Marcel's suggestion :)

Cheers,
Arman
