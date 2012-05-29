Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120529142537.GB13737@samus>
References: <1338293498-2356-1-git-send-email-luiz.dentz@gmail.com>
	<20120529142537.GB13737@samus>
Date: Tue, 29 May 2012 21:08:38 +0300
Message-ID: <CABBYNZ+spAWjmXkz+-AOSXVigW73hvYr-5UBkc1PBRfzOa03TQ@mail.gmail.com>
Subject: Re: [PATCH obexd] client: Fix not checking if destination exist while
 renaming file
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, May 29, 2012 at 5:25 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Luiz,
>
> On 15:11 Tue 29 May, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> rename return an error if the destination directory doesn't exist, so
>> in case it doesn't exist it should be created before calling rename.
>> ---
>>  client/transfer.c |   27 +++++++++++++++++++++++++--
>>  1 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/client/transfer.c b/client/transfer.c
>> index 3065c9c..772834f 100644
>> --- a/client/transfer.c
>> +++ b/client/transfer.c
>> @@ -715,11 +715,34 @@ int obc_transfer_set_filename(struct obc_transfer *transfer,
>>                                       const char *filename)
>>  {
>>       int err;
>> +     struct stat st;
>> +     char *dirname;
>> +     gboolean dir = FALSE;
>> +
>> +     dirname = g_path_get_dirname(filename);
>> +     if (stat(dirname, &st) < 0) {
>> +             if (errno != ENOENT) {
>> +                     error("stat(): %s (%d)", strerror(errno), errno);
>> +                     return -errno;
>> +             }
>> +
>> +             if (mkdir(dirname, 0755) < 0) {
>
> For example, if my /tmp is empty, and "dirname" is "/tmp/foo/bar", this
> would fail, right? i.e. mkdir() isn't able to create two (or more) levels
> at a time.
>
> So for consistency, I would prefer if the error that the directory
> doesn't exist is returned, and the user creates the directory himself.
> This is mostly for FTP, right?

This is a regression when the Agent returns a different path to save
the file it used to work, but since we are going to remove the agent
maybe this function doesn't make sense anymore so the application need
to set the filename upfront.


-- 
Luiz Augusto von Dentz
