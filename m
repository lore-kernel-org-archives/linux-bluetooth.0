Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25SLjFr4iaKy8WJAfrz0oZpqENpkBJesNd4_xa_br+E6cA@mail.gmail.com>
References: <1413234602-20566-1-git-send-email-armansito@chromium.org>
	<CAHrH25SLjFr4iaKy8WJAfrz0oZpqENpkBJesNd4_xa_br+E6cA@mail.gmail.com>
Date: Mon, 20 Oct 2014 15:09:13 +0300
Message-ID: <CABBYNZJ0gvAx00rL_sTrG2ktm0jiYpRFo4=fSRCeAey+vQ9DXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce shared/gatt-server.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Oct 16, 2014 at 9:49 PM, Arman Uguray <armansito@chromium.org> wrote:
> On Mon, Oct 13, 2014 at 2:09 PM, Arman Uguray <armansito@chromium.org> wrote:
>> *v2:
>>   - Split read_by_grp_type_cb into two functions by moving the response PDU
>>     encoding loop into a helper function.
>>
>> *v1:
>>   - Make gatt-db external to gatt-server, as initially discussed.
>>   - Also implement Read By Group Type request.
>>
>> Arman Uguray (5):
>>   shared/att: Drop the connection if a request is received while one is
>>     pending.
>>   shared/att: Respond with ERROR_REQUEST_NOT_SUPPORTED for unhandled
>>     requests.
>>   shared/gatt-server: Introduce shared/gatt-server.
>>   shared/gatt-server: Support Exchange MTU request.
>>   shared/gatt-server: Support Read By Group Type request.
>>
>>  Makefile.am              |   1 +
>>  src/shared/att.c         | 124 +++++++++++------
>>  src/shared/gatt-server.c | 356 +++++++++++++++++++++++++++++++++++++++++++++++
>>  src/shared/gatt-server.h |  40 ++++++
>>  4 files changed, 481 insertions(+), 40 deletions(-)
>>  create mode 100644 src/shared/gatt-server.c
>>  create mode 100644 src/shared/gatt-server.h
>>
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>
> ping. Luiz made comments on one of the patches but I believe they've
> been addressed.
> --

This is now pushed, note that Ive made a couple changes both in the
code and the commit message, please next time follow 50/72 format for
the commit message (check HACKING if you don't know what Im talking
about).


-- 
Luiz Augusto von Dentz
