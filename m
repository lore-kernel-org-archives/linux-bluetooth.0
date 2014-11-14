Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415933393-28902-1-git-send-email-armansito@chromium.org>
References: <1415933393-28902-1-git-send-email-armansito@chromium.org>
Date: Fri, 14 Nov 2014 15:35:46 +0200
Message-ID: <CABBYNZ+4vTGcdwM3gNBXMh-HK9SBRea-pSgCU8GuTmk7abwNNg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/7] Introduce tools/btgatt-server and other bug fixes.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Nov 14, 2014 at 4:49 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set introduces tools/btgatt-server. This tool serves as a
> standalone demo of combining shared/gatt-db, shared/gatt-server, and a
> listening L2CAP socket on the ATT channel. The tool exposes the GAP and
> GATT services, as well as a Heart Rate service. It's possible to hide/unhide
> the latter to test Service Changed events.
>
> The set also includes two small bug fixes for the way Service Changed
> characteristics are handled by shared/gatt-client.
>
> *v1: Fixed Luiz's comments:
>      - Style fixes.
>      - Make certain attribute values cached directly in gatt-db.
>      - Added an ATT error response encoding API and packed struct.
>
> *v2: Change bt_att_encode_error_rsp to bt_att_send_error_rsp.
>
> Arman Uguray (7):
>   shared/att: Add API for sending ATT error response.
>   tools/btgatt-server: Introduce btgatt-server.
>   tools/btgatt-server: Accept incoming connection and initialize server.
>   tools/btgatt-server: Populate the database.
>   tools/btgatt-server: Add command support and the notify command.
>   tools/btgatt-server: Add Heart Rate service simulation.
>   tools/btgatt-server: Add "heart-rate" command.
>
>  .gitignore                |    1 +
>  Makefile.tools            |    8 +
>  src/shared/att-types.h    |   12 +
>  src/shared/att.c          |   60 ++-
>  src/shared/att.h          |    3 +
>  src/shared/gatt-client.c  |    8 +-
>  src/shared/gatt-helpers.c |    8 +-
>  src/shared/gatt-server.c  |  208 +++------
>  tools/btgatt-server.c     | 1088 +++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 1242 insertions(+), 154 deletions(-)
>  create mode 100644 tools/btgatt-server.c
>
> --
> 2.1.0.rc2.206.gedb03e5

Ive aplied the first one, please fix the build for 2/7 and 3/7 if
possible. Btw I notice that sometimes you do casts without spaces in
between, please fix that as well.


-- 
Luiz Augusto von Dentz
