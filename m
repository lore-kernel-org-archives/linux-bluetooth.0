Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Date: Thu, 22 Jan 2015 16:17:12 +0200
Message-ID: <CABBYNZKjxqs987YbokxTAKUWEGNo5tMQL6+RGXQcvu_gdh1qWA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/23] More server GATT Test Spec tests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Jan 21, 2015 at 10:28 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Adds the remaining tests possible to implement given the current state
> of gatt-server.  Functionality found broken or lacking was implemented.
>
> Read multiple is now supported.
>
> Michael Janssen (23):
>   unit/gatt: Add /TP/GAD/CL/BV-05-C test
>   unit/gatt: Add /TP/GAD/SR/BV-05-C test
>   unit/gatt: Add /TP/GAR/SR/BV-03-C test
>   unit/gatt: Add /TP/GAR/SR/BI-06-C test
>   unit/gatt: Add /TP/GAR/SR/BI-07-C test
>   unit/gatt: Add /TP/GAR/SR/BI-08-C test
>   unit/gatt: Add /TP/GAR/SR/BV-04-C test
>   unit/gatt: Add /TP/GAR/SR/BI-12-C test
>   shared/gatt-db: fix error read from invalid offset
>   unit/gatt: Add /TP/GAR/SR/BI-13-C test
>   unit/gatt: Add /TP/GAR/SR/BI-14-C test
>   shared/gatt-server: Add read multiple support.
>   unit/gatt: Add /TP/GAR/SR/BV-05-C test
>   unit/gatt: Add /TP/GAR/SR/BI-18-C test
>   unit/gatt: Add /TP/GAR/SR/BI-19-C test
>   unit/gatt: Add /TP/GAR/SR/BV-06-C test
>   unit/gatt: Add /TP/GAR/SR/BI-23-C test
>   unit/gatt: Add /TP/GAR/SR/BI-24-C test
>   unit/gatt: Add /TP/GAR/SR/BV-07-C test
>   unit/gatt: Add /TP/GAR/SR/BV-08-C test
>   unit/gatt: Add /TP/GAR/SR/BI-28-C test
>   unit/gatt: Add /TP/GAR/SR/BI-29-C test
>   unit/gatt: Add /TP/GAR/SR/BI-30-C test
>
>  src/shared/gatt-db.c     |   7 +-
>  src/shared/gatt-server.c | 154 ++++++++++++++++++++++++++
>  unit/test-gatt.c         | 276 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 435 insertions(+), 2 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
