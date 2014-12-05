Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417712635-12428-1-git-send-email-jamuraa@chromium.org>
References: <1417712635-12428-1-git-send-email-jamuraa@chromium.org>
Date: Fri, 5 Dec 2014 17:06:04 +0200
Message-ID: <CABBYNZLjsOQsibvtWm=rc8E2k96U-=p-=Yk01rtg+bu_Pq3qmg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] unit/gatt: Replace custom structs with gatt_db
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Dec 4, 2014 at 7:03 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> These patches replace the custom structs in test-gatt with building an
> appropriate gatt_db and comparing the rebuilt client gatt_db with the source.
>
> This set replaces service_data_1 with a gatt_db made by make_service_1_db(),
> which is still closely tied to the SERVICE_DATA_1_PDU.
>
> Michael Janssen (2):
>   unit/gatt: Use gatt_db for test data
>   Remove unused old test db structures
>
>  unit/test-gatt.c | 425 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 226 insertions(+), 199 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied after changing add_char_with_value,
gatt_db_service_add_characteristic returns you the value attribute so
you can write directly to it.

-- 
Luiz Augusto von Dentz
