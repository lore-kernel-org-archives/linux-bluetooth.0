Return-Path: <cyrus@holtmann.org>
Message-ID: <20110617134150.947246py42dt6ni8@mail.hendrik-sattler.de>
Date: Fri, 17 Jun 2011 13:41:50 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 2/4] Add basic support for action commands on ftp
 driver
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
 <1308292007-2111-2-git-send-email-luiz.dentz@gmail.com>
 <20110617121950.13306qfj8egbctc0@mail.hendrik-sattler.de>
 <BANLkTi=kO_A2cruBQQ7CBDL2h-v-VVPCFA@mail.gmail.com>
In-Reply-To: <BANLkTi=kO_A2cruBQQ7CBDL2h-v-VVPCFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Zitat von Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> On Fri, Jun 17, 2011 at 1:19 PM, Hendrik Sattler
> <post@hendrik-sattler.de> wrote:
>> Zitat von Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>>
>>> +static char *ftp_build_filename(struct ftp_session *ftp, const char
>>> *destname)
>>> +{
>>> +       char *filename;
>>> +
>>> +       /* DestName can either be relative or absolute (FTP style) */
>>> +       if (g_path_is_absolute(destname))
>>> +               filename = g_build_filename(destname, NULL);
>>> +       else
>>> +               filename = g_build_filename(ftp->folder, destname, NULL);
>>> +
>>> +       /* Check if destination is inside root path */
>>> +       if (g_str_has_prefix(filename, ftp->folder))
>>> +               return filename;
>>> +
>>> +       g_free(filename);
>>> +
>>> +       return NULL;
>>> +}
>>
>> You should also catch stuff like the UNC path stuff and drive letter
>> prefixes. No need to support all the sick stuff :-/
>
> If g_build_filename doesn't care I don't see why we should care.

Because strings like "\\..." and "C:\..." may return 0 with  
g_path_is_absolute(destname) and you then use a wrong directory that  
is not according to spec.

HS

