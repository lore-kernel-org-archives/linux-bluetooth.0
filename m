Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKOpW6rbptUrAMyAN6Su3rU+13z4P0+7CVghCRmjCmOUQ@mail.gmail.com>
References: <20171226035508.30625-1-ahmeds2000x@gmail.com> <20171226035508.30625-2-ahmeds2000x@gmail.com>
 <CABBYNZLmr7RJjoebXCgHSjqeUoeTdu1EmiQeBi_Ba-yyhojAFw@mail.gmail.com> <CABBYNZKOpW6rbptUrAMyAN6Su3rU+13z4P0+7CVghCRmjCmOUQ@mail.gmail.com>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
Date: Tue, 26 Dec 2017 17:22:16 +0100
Message-ID: <CAHU4CU+3yOG1em1daEevrCjovxO28UO1ZTsm9y39n_TQWqmYig@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Fix bug in characteristic_start_notify.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 26, 2017 at 2:18 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Ahmed,
> Note that StartNotify is intended to work offline, so when it connects it
> will subscribe which seem this would prevent that to happen.

Thanks for the clarification, this does indeed prevent that from
happening, sorry for the silly mistake on my side.
