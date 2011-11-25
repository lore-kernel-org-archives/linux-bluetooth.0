Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111124182457.GB20733@samus>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
	<1322143742-31182-6-git-send-email-mikel.astiz@bmw-carit.de>
	<20111124182457.GB20733@samus>
Date: Fri, 25 Nov 2011 13:52:07 +0200
Message-ID: <CABBYNZ+T_j_4340NXefxH833tr-zdiy446yJnFDp58SoqDLnZw@mail.gmail.com>
Subject: Re: [RFC obexd 05/10] client-doc: replace parameter dict with
 conventional ones
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel, Vinicius,

On Thu, Nov 24, 2011 at 8:24 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Mikel,
>
> On 15:08 Thu 24 Nov, Mikel Astiz wrote:
>> The usage of a dictionary as a parameter passing mechanism seems not to
>> be necessary any more.
>> ---
>>  doc/client-api.txt |   22 ++++++++++------------
>>  1 files changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/doc/client-api.txt b/doc/client-api.txt
>> index a6f30af..67355c6 100644
>> --- a/doc/client-api.txt
>> +++ b/doc/client-api.txt
>> @@ -12,27 +12,25 @@ Service           org.openobex.client
>>  Interface    org.openobex.Client
>>  Object path  /
>>
>> -Methods              object CreateSession(dict device)
>> +Methods              object CreateSession(string source, string destination,
>> +                                     string target)
>>
>> -                     Create a new OBEX session. The device is configured
>> -                     via properties like in SendFiles.
>> +                     Create a new OBEX session for the given source (local)
>> +                     address, destination (remote) address and target. The
>> +                     supported target values are:
>> +                             - "OPP"
>> +                             - "FTP"
>> +                             - "SYNC"
>> +                             - "PBAP"
>>
>>               void RemoveSession(object session)
>>
>>                       Unregister session and abort pending transfers.
>>
>> -             string GetCapabilities(dict device)
>> +             string GetCapabilities(string source, string destination)
>>
>>                       Get remote device capabilities.
>>
>> -Properties   string Target
>> -
>> -             string Source
>> -
>> -             string Destination
>> -
>> -             byte Channel
>
> I just wanted to say that for most of the cases doing the SDP seach
> always is the right thing to do, but sometimes you want to avoid it.
>
> I agree that for now we can leave it, but it would be nice if there
> was a way to add it later if we ever need it.

IMO it is better to leave as it is because then some parameters can be
omitted such as adapter and target, and it also easier to extend if we
need other parameters e.g. WHO header without breaking the signature.


-- 
Luiz Augusto von Dentz
