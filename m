Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PRhYf5FKYn3O7FM0qYNA2Tdt28bcMtq_WUCbN3moDDYQ@mail.gmail.com>
References: <1328607191-9550-1-git-send-email-sancane@gmail.com>
	<1328607191-9550-2-git-send-email-sancane@gmail.com>
	<CAJdJm_PRhYf5FKYn3O7FM0qYNA2Tdt28bcMtq_WUCbN3moDDYQ@mail.gmail.com>
Date: Tue, 7 Feb 2012 13:13:05 +0100
Message-ID: <CACLukzLv1pi5WoPdzbCYFA+wGQhLdwBQ7nf6htd546xRRSyQSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] attrib-server: Fix bad error message
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2012/2/7 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Tue, Feb 7, 2012 at 5:33 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> ---
>>  src/attrib-server.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/attrib-server.c b/src/attrib-server.c
>> index a23d5d2..3d4634f 100644
>> --- a/src/attrib-server.c
>> +++ b/src/attrib-server.c
>> @@ -171,7 +171,7 @@ static struct gatt_server *find_gatt_server(const bdaddr_t *bdaddr)
>>                char addr[18];
>>
>>                ba2str(bdaddr, addr);
>> -               error("Not GATT adapter found for address %s", addr);
>> +               error("Not GATT server found in %s", addr);
>
> You can also fix: Not -> No
>
>>                return NULL;
>>        }
>>
>> --
>> 1.7.9
>
 Ok, ignore these two patches, I'll send another ones ASAP
