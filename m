Return-Path: <cyrus@holtmann.org>
From: <Arkadiusz.Lichwa@tieto.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Fri, 15 Jul 2011 15:31:59 +0300
Subject: RE: [PATCH] Fix mem leak in sap plugin
Message-ID: <BF2CDDEFEC2D1E42A67A8AE0508897EC3E8018921D@EXMB02.eu.tieto.com>
References: <1310729911-12075-1-git-send-email-arkadiusz.lichwa@tieto.com>
 <CABBYNZL1-GBi+DUHVR+WsnFDsLwDVYCvsbXPw0kMtDZ3Fcjhsw@mail.gmail.com>
In-Reply-To: <CABBYNZL1-GBi+DUHVR+WsnFDsLwDVYCvsbXPw0kMtDZ3Fcjhsw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz
>Hi,
>
>On Fri, Jul 15, 2011 at 2:38 PM, Arek Lichwa <arkadiusz.lichwa@tieto.com>
>wrote:
>> When dropping rfcomm channel to sap server, the component's channel
>> cleanup process doesn't release assigned glib channel resources.
>> ---
>>  sap/server.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/sap/server.c b/sap/server.c
>> index c55aa6e..8bd8fe1 100644
>> --- a/sap/server.c
>> +++ b/sap/server.c
>> @@ -1122,7 +1122,6 @@ static void sap_io_destroy(void *data)
>>                                conn->state ==
>SAP_STATE_GRACEFUL_DISCONNECT)
>>                        sap_disconnect_req(NULL, 1);
>>
>> -               conn->io = NULL;
>>                sap_conn_remove(conn);
>>        }
>>  }
>> --
>> 1.7.6
>
>It doesn't seems this release any memory, maybe the problem is not a
>memory leak but an invalid access to freed memory?

Actually the realese/cleanup process of glib resource isn't triggered.
It would when last reference to conn->io get 0. It's been triggered in 
sap_conn_remove() but conn->io already got null before that.
So it needs better description ?

/Arek
>
>--
>Luiz Augusto von Dentz
