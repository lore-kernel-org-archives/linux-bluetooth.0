Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413234602-20566-1-git-send-email-armansito@chromium.org>
References: <1413234602-20566-1-git-send-email-armansito@chromium.org>
Date: Thu, 16 Oct 2014 11:49:41 -0700
Message-ID: <CAHrH25SLjFr4iaKy8WJAfrz0oZpqENpkBJesNd4_xa_br+E6cA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce shared/gatt-server.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 13, 2014 at 2:09 PM, Arman Uguray <armansito@chromium.org> wrote:
> *v2:
>   - Split read_by_grp_type_cb into two functions by moving the response PDU
>     encoding loop into a helper function.
>
> *v1:
>   - Make gatt-db external to gatt-server, as initially discussed.
>   - Also implement Read By Group Type request.
>
> Arman Uguray (5):
>   shared/att: Drop the connection if a request is received while one is
>     pending.
>   shared/att: Respond with ERROR_REQUEST_NOT_SUPPORTED for unhandled
>     requests.
>   shared/gatt-server: Introduce shared/gatt-server.
>   shared/gatt-server: Support Exchange MTU request.
>   shared/gatt-server: Support Read By Group Type request.
>
>  Makefile.am              |   1 +
>  src/shared/att.c         | 124 +++++++++++------
>  src/shared/gatt-server.c | 356 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-server.h |  40 ++++++
>  4 files changed, 481 insertions(+), 40 deletions(-)
>  create mode 100644 src/shared/gatt-server.c
>  create mode 100644 src/shared/gatt-server.h
>
> --
> 2.1.0.rc2.206.gedb03e5
>

ping. Luiz made comments on one of the patches but I believe they've
been addressed.
