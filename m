Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
Message-ID: <20040627171336.GA25886@gmx.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <20040627125235.GA15938@gmx.net> <001101c45c55$7803b160$0364a8c0@haruo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001101c45c55$7803b160$0364a8c0@haruo>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 27 Jun 2004 19:13:36 +0200

On  0, KeiHachi <keihachi@swissinfo.org> wrote:
> Thanks for your reply, nicholas.
> > If this is the first GPL software you are using, please read and 
> > understand the implications of this license. This is no offense, but i
> > think some DVD and Router manufacturer didn't do this before integrating
> > linux code in their products.
> 
> Thanks.
> I know the topic of GPL in Linux world of course,
> so we have already studied about the license issues,
> and will continue to study more & more about it from now.


> > > - eSCO (enhanced SCO) in Bluetooth 1.2
> > > Do you have any plan to develop these?
> > 
> > I am not Marcel and not writing any kernel code, but i listened his talk
> > at Linuxtag Karlsruhe. I think the problem is the lack of the end-user
> > products already supporting this. But it is on his plan:
> > 
> > http://www.holtmann.org/papers/bluetooth/lt2004_slides.pdf
> 
> Thanks.
> I think he will need to spend a little extra time (maybe a few months) 
> for supporting eSCO. 

I think if you pay him for supporting eSCO, then it will be very quickly
integrated.

> > > - Audio/Video related profiles
> > > Do you have any plan to develop these(A2DP, AVRCP)?
> > 
> > He posted some time ago a request, that if people supply him such
> > hardware he would implent those support.
> 
> Do you mean that offering a headphone with Bluetooth audio functionality
> to him is necessary to develop A2DP?

Look here:
http://sourceforge.net/mailarchive/message.php?msg_id=8643774
I don't know whether someone donated anything after this request, but I
think he can't get enought. ;)

> > I don't understand, are you looking for a company that provides such
> > support or you want to start a business providing such support?
> > I don't know of the first, but contacting the developer directly, one
> > may provide such support. The second is of course possible.
> 
> I supposed the first one you mentioned. The latter one is out of my 
> supposition.
> If you have a few guesses about such a company that provides the 
> support of using BlueZ, please tell me the name of such a company.

I don't know of any...

> Or, please forgive me for asking this rude question, but,
> could the developers of BlueZ community provide the support to ensure 
> the quality,  as counter value for some maintenance fee?

..but i am quite sure this might be possible. Marcel while probably
reply itself. He is the best suited person, for such a job.

> > It is so stable, you don't need one, ;) Just kidding. Why do you think,
> > there is no stable version? I think the releases are considered stable
> > and the CVS stuff and the utils2/libs2 are the testing branch.
> 
> For example, Affix provides us these two versions software,
> the testing version and the stable version.
> http://affix.sourceforge.net/#download
> 
> I suppose such version control or management like Affix.
> 
> If a new profile is testing or has been released immediately 
> after the development,  probably some bugs are still included.
> So we think if BlueZ is used for the commercial use, the stable 
> version is necessary,
> because a commercial product is required to be a high quality.

Yeah I understand your problem and IMO you are partly right. There is no
so strict seperation of a testing and a stable tree. But you have to
seperate: the generic ACL/RFCOMM support is quite stable. You can use
it without integrating all those parts which might be considered not
completely stable. 
I personaly wouldn't use HID or SCO support in a commercial device.

> If I misundersood, I am sorry.
> The utils2/libs2 are the testing version, the others are the 
> stable version, you mean?

yes 

> If so, is the modification of the kernel part still stable?

You mean those -mh patches for 2.6?

nicholas


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
