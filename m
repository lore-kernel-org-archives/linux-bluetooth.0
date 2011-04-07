Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1302010586-12397-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1302010586-12397-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Thu, 7 Apr 2011 09:59:05 -0400
Message-ID: <BANLkTimCgeoJMf97AOpNwkg5CPZJU0-kyA@mail.gmail.com>
Subject: Re: [PATCH] Add attrib_db_clear() to attribute server API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 5, 2011 at 9:36 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> This function allows some external plugin to totally reimplement the
> attribute server by replacing all attributes (including the GAP ones).
>
> Note that it is not safe to call this function while there are active
> client connections.
> ---
>  src/attrib-server.c |   29 +++++++++++++++++++++++++++++
>  src/attrib-server.h |    1 +
>  2 files changed, 30 insertions(+), 0 deletions(-)

Please ignore this patch. I will send another one which also removes
the SDP records registered for GATT/GAP.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
