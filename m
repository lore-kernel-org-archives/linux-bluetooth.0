Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001201d03c96$10ca2ab0$325e8010$@samsung.com>
References: <1422452517-4240-1-git-send-email-gowtham.ab@samsung.com>
	<001201d03c96$10ca2ab0$325e8010$@samsung.com>
Date: Fri, 30 Jan 2015 17:32:53 +0200
Message-ID: <CABBYNZKWB+dLTKgP-_znxrycq8VK8jNJPmVaGGBWPhK5Vf0BLw@mail.gmail.com>
Subject: Re: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Jan 30, 2015 at 4:07 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Wednesday, January 28, 2015 7:12 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
>> Babu
>> Subject: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
>>
>> Adds support to fetch spd,fav phonebook.
>> Tested using PTS test case TC_PCE_PBB_BV_01_C.
>> ---
>>  test/pbap-client | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/test/pbap-client b/test/pbap-client index 51e26eb..16a786b
>> 100755
>> --- a/test/pbap-client
>> +++ b/test/pbap-client
>> @@ -170,6 +170,6 @@ if  __name__ == '__main__':
>>
>>               pbap_client.flush_transfers(lambda: test_paths(paths[1:]))
>>
>> -     test_paths(["PB", "ICH", "OCH", "MCH", "CCH"])
>> +     test_paths(["PB", "ICH", "OCH", "MCH", "CCH", "SPD", "FAV"])
>>
>>       mainloop.run()
>> --
>> 1.9.1

We should be doing this with obexctl, is there something missing there?


-- 
Luiz Augusto von Dentz
