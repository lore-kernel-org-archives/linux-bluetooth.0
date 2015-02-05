Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1422452517-4240-1-git-send-email-gowtham.ab@samsung.com>
 <001201d03c96$10ca2ab0$325e8010$@samsung.com>
 <CABBYNZKWB+dLTKgP-_znxrycq8VK8jNJPmVaGGBWPhK5Vf0BLw@mail.gmail.com>
 <000801d03eb4$99812f00$cc838d00$@samsung.com>
In-reply-to: <000801d03eb4$99812f00$cc838d00$@samsung.com>
Subject: RE: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
Date: Thu, 05 Feb 2015 15:02:27 +0530
Message-id: <000401d04126$ad2c2ae0$078480a0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Monday, February 02, 2015 12:21 PM
> To: 'Luiz Augusto von Dentz'
> Cc: linux-bluetooth@vger.kernel.org; 'Bharat Panda'; cpgs@samsung.com
> Subject: RE: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
> 
> Hi Luiz,
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> > Sent: Friday, January 30, 2015 9:03 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org; Bharat Panda; cpgs@samsung.com
> > Subject: Re: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
> >
> > Hi Gowtham,
> >
> > On Fri, Jan 30, 2015 at 4:07 PM, Gowtham Anandha Babu
> > <gowtham.ab@samsung.com> wrote:
> > > Ping.
> > >
> > >> -----Original Message-----
> > >> From: linux-bluetooth-owner@vger.kernel.org
> > >> [mailto:linux-bluetooth- owner@vger.kernel.org] On Behalf Of
> > >> Gowtham Anandha Babu
> > >> Sent: Wednesday, January 28, 2015 7:12 PM
> > >> To: linux-bluetooth@vger.kernel.org
> > >> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham
> > Anandha Babu
> > >> Subject: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
> > >>
> > >> Adds support to fetch spd,fav phonebook.
> > >> Tested using PTS test case TC_PCE_PBB_BV_01_C.
> > >> ---
> > >>  test/pbap-client | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/test/pbap-client b/test/pbap-client index
> > >> 51e26eb..16a786b
> > >> 100755
> > >> --- a/test/pbap-client
> > >> +++ b/test/pbap-client
> > >> @@ -170,6 +170,6 @@ if  __name__ == '__main__':
> > >>
> > >>               pbap_client.flush_transfers(lambda:
> > >> test_paths(paths[1:]))
> > >>
> > >> -     test_paths(["PB", "ICH", "OCH", "MCH", "CCH"])
> > >> +     test_paths(["PB", "ICH", "OCH", "MCH", "CCH", "SPD", "FAV"])
> > >>
> > >>       mainloop.run()
> > >> --
> > >> 1.9.1
> >
> > We should be doing this with obexctl, is there something missing there?
> >
> >
> 
> In obexctl, we are selecting the phonebook based on user input. We are
> passing that as a dbus args simply without checking.
> All this phonebook objects ["PB", "ICH", "OCH", "MCH", "CCH", "SPD", "FAV"]
> are getting selected using obexctl.
> If we give other than the above mentioned phonebook, its showing '
> org.bluez.obex.Error.InvalidArguments '.
> Below is the log for the same.
> 
> [00:1B:DC:07:33:4E]# cd pb
> Attempting to Select to pb
> Select successful
> [00:1B:DC:07:33:4E]# cd och
> Attempting to Select to och
> Select successful
> [00:1B:DC:07:33:4E]# cd ich
> Attempting to Select to ich
> Select successful
> [00:1B:DC:07:33:4E]# cd mch
> Attempting to Select to mch
> Select successful
> [00:1B:DC:07:33:4E]# cd spd
> Attempting to Select to spd
> Select successful
> [00:1B:DC:07:33:4E]# cd fav
> Attempting to Select to fav
> Select successful
> [00:1B:DC:07:33:4E]# cd sdfa
> Attempting to Select to sdfa
> Failed to Select: org.bluez.obex.Error.InvalidArguments
> 
> Do we need to add a check before passing this args? Because dbus itself is
> handling this issue by sending 'org.bluez.obex.Error.InvalidArguments'.
> I don’t think extra check is not required here.
> What do you think?
> 
> Regards,
> Gowtham Anandha Babu
> 
> > --
> > Luiz Augusto von Dentz
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

