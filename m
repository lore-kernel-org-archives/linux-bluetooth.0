Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 19 Mar 2018 13:51:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: avichal <avichal.a@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com,
        anupam.r@samsung.com
Subject: Re: [PATCH BlueZ 2/2] gatt-database: Add support for Included service
Message-ID: <20180319115138.GA14292@x1c.lan>
References: <CABBYNZJ_QegMdkc1yE462Dpu6Vfdot3SP3FNuPQZ1-SajwAFEQ@mail.gmail.com>
 <CGME20180316131046epcas1p1016f3684a15ae62cfce0cecef9d6a5c4@epcas1p1.samsung.com>
 <1521205746-3636-1-git-send-email-avichal.a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521205746-3636-1-git-send-email-avichal.a@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Avichal,

On Fri, Mar 16, 2018, avichal wrote:
> Add support of included services in gatt server.While
> registring the service new property is added
> "includes"
>         array{object} type  [read-only]
>         Array of object paths representing the included
>         services of this service.
> ---
>  src/gatt-database.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)

Please fix your git author information to be of the format "Firstname
Lastname <email>". We don't generally accept patches with a username or
just the first name. Some have slipped through in the past, and for that
we have the .mailmap file in the tree - I don't think you want an entry
for yourself there ;)

Johan
