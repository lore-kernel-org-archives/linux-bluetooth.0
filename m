Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000401d04126$ad2c2ae0$078480a0$@samsung.com>
References: <1422452517-4240-1-git-send-email-gowtham.ab@samsung.com>
	<001201d03c96$10ca2ab0$325e8010$@samsung.com>
	<CABBYNZKWB+dLTKgP-_znxrycq8VK8jNJPmVaGGBWPhK5Vf0BLw@mail.gmail.com>
	<000801d03eb4$99812f00$cc838d00$@samsung.com>
	<000401d04126$ad2c2ae0$078480a0$@samsung.com>
Date: Thu, 5 Feb 2015 12:32:44 +0200
Message-ID: <CABBYNZ+Yv2aH-WuN+yNDmyO=q7MvfQO7sN3s6TgrVn=pj25gag@mail.gmail.com>
Subject: Re: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Feb 5, 2015 at 11:32 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Monday, February 02, 2015 12:21 PM
>> To: 'Luiz Augusto von Dentz'
>> Cc: linux-bluetooth@vger.kernel.org; 'Bharat Panda'; cpgs@samsung.com
>> Subject: RE: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
>>
>> Hi Luiz,
>>
>> > -----Original Message-----
>> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> > owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> > Sent: Friday, January 30, 2015 9:03 PM
>> > To: Gowtham Anandha Babu
>> > Cc: linux-bluetooth@vger.kernel.org; Bharat Panda; cpgs@samsung.com
>> > Subject: Re: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
>> >
>> > Hi Gowtham,
>> >
>> > On Fri, Jan 30, 2015 at 4:07 PM, Gowtham Anandha Babu
>> > <gowtham.ab@samsung.com> wrote:
>> > > Ping.
>> > >
>> > >> -----Original Message-----
>> > >> From: linux-bluetooth-owner@vger.kernel.org
>> > >> [mailto:linux-bluetooth- owner@vger.kernel.org] On Behalf Of
>> > >> Gowtham Anandha Babu
>> > >> Sent: Wednesday, January 28, 2015 7:12 PM
>> > >> To: linux-bluetooth@vger.kernel.org
>> > >> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham
>> > Anandha Babu
>> > >> Subject: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
>> > >>
>> > >> Adds support to fetch spd,fav phonebook.
>> > >> Tested using PTS test case TC_PCE_PBB_BV_01_C.
>> > >> ---
>> > >>  test/pbap-client | 2 +-
>> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >>
>> > >> diff --git a/test/pbap-client b/test/pbap-client index
>> > >> 51e26eb..16a786b
>> > >> 100755
>> > >> --- a/test/pbap-client
>> > >> +++ b/test/pbap-client
>> > >> @@ -170,6 +170,6 @@ if  __name__ == '__main__':
>> > >>
>> > >>               pbap_client.flush_transfers(lambda:
>> > >> test_paths(paths[1:]))
>> > >>
>> > >> -     test_paths(["PB", "ICH", "OCH", "MCH", "CCH"])
>> > >> +     test_paths(["PB", "ICH", "OCH", "MCH", "CCH", "SPD", "FAV"])
>> > >>
>> > >>       mainloop.run()
>> > >> --
>> > >> 1.9.1

Applied, thanks.
