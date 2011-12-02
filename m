Return-Path: <cyrus@holtmann.org>
Message-id: <90B4470ABE8C438C9650ED03BF611926@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1322827022-27391-1-git-send-email-jaganath.k@samsung.com>
 <CABBYNZ+uimY=eA6PnND5mqeAj2411rk0hseXp1PXbdEDt6P4vw@mail.gmail.com>
In-reply-to: <CABBYNZ+uimY=eA6PnND5mqeAj2411rk0hseXp1PXbdEDt6P4vw@mail.gmail.com>
Subject: Re: [PATCH obexd] Fix file size issue in GetProperties
Date: Fri, 02 Dec 2011 18:30:09 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Friday, December 02, 2011 6:11 PM
To: <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd] Fix file size issue in GetProperties

> Hi Jaganath,
>
> On Fri, Dec 2, 2011 at 1:57 PM,  <jaganath.k@samsung.com> wrote:
>> From: jaganath.k <jaganath.k@samsung.com>
>>
>> In SendFiles, If application calls GetProperties before
>> Request method returns then the file size is zero.
>> ---
>>  client/session.c  |    4 ++++
>>  client/transfer.c |   40 ++++++++++++++++++++++++----------------
>>  client/transfer.h |    1 +
>>  3 files changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/client/session.c b/client/session.c
>> index f288ecd..9f02512 100644
>> --- a/client/session.c
>> +++ b/client/session.c
>> @@ -1277,6 +1277,10 @@ int obc_session_send(struct obc_session *session, 
>> const char *filename,
>>        if (transfer == NULL)
>>                return -EINVAL;
>>
>> +       err = obc_transfer_set_file(transfer);
>> +       if (err < 0)
>> +               goto fail;
>> +
>>        /* Transfer should start if it is the first in the pending list */
>>        if (transfer != session->pending->data)
>>                return 0;
>> diff --git a/client/transfer.c b/client/transfer.c
>> index b6994d1..5b67d1e 100644
>> --- a/client/transfer.c
>> +++ b/client/transfer.c
>> @@ -563,8 +563,6 @@ int obc_transfer_put(struct obc_transfer *transfer, 
>> transfer_callback_t func,
>>        GObex *obex;
>>        GObexPacket *req;
>>        GObexDataProducer data_cb;
>> -       struct stat st;
>> -       int fd;
>>
>>        if (transfer->xfer != 0)
>>                return -EALREADY;
>> @@ -574,20 +572,6 @@ int obc_transfer_put(struct obc_transfer *transfer, 
>> transfer_callback_t func,
>>                goto done;
>>        }
>>
>> -       fd = open(transfer->filename, O_RDONLY);
>> -       if (fd < 0) {
>> -               error("open(): %s(%d)", strerror(errno), errno);
>> -               return -errno;
>> -       }
>> -
>> -       if (fstat(fd, &st) < 0) {
>> -               close(fd);
>> -               error("fstat(): %s(%d)", strerror(errno), errno);
>> -               return -errno;
>> -       }
>> -
>> -       transfer->fd = fd;
>> -       transfer->size = st.st_size;
>>        data_cb = put_xfer_progress;
>>
>>  done:
>> @@ -667,3 +651,27 @@ gint64 obc_transfer_get_size(struct obc_transfer 
>> *transfer)
>>  {
>>        return transfer->size;
>>  }
>> +
>> +int obc_transfer_set_file(struct obc_transfer *transfer)
>> +{
>> +       int fd;
>> +       struct stat st;
>> +
>> +       fd = open(transfer->filename, O_RDONLY);
>> +       if (fd < 0) {
>> +               error("open(): %s(%d)", strerror(errno), errno);
>> +               return -errno;
>> +       }
>> +
>> +       if (fstat(fd, &st) < 0) {
>> +               error("fstat(): %s(%d)", strerror(errno), errno);
>> +               close(fd);
>> +               return -errno;
>> +       }
>> +
>> +       transfer->fd = fd;
>> +       transfer->size = st.st_size;
>> +
>> +       return 0;
>> +}
>> +
>> diff --git a/client/transfer.h b/client/transfer.h
>> index ba53fd1..c051cbd 100644
>> --- a/client/transfer.h
>> +++ b/client/transfer.h
>> @@ -55,3 +55,4 @@ void obc_transfer_clear_buffer(struct obc_transfer 
>> *transfer);
>>  void obc_transfer_set_name(struct obc_transfer *transfer, const char 
>> *name);
>>  const char *obc_transfer_get_path(struct obc_transfer *transfer);
>>  gint64 obc_transfer_get_size(struct obc_transfer *transfer);
>> +int obc_transfer_set_file(struct obc_transfer *transfer);
>> --
>
> Nice catch, but I would like to avoid another public function for
> this, so how about making obc_transfer_set_file static on transfer.c
> calling it in obc_transfer_register?
>
> -- 
> Luiz Augusto von Dentz
> --

obc_transfer_register is being called from obc_session_get which
eventually calls obc_transfer_get in which if transfer->name is NULL
transfer->filename is open with write mode. obc_session_get is used from
pbap and sync with name as NULL and filename as NOT NULL.

Thanks and Regards
Jaganath 

