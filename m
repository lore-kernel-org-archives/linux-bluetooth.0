Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001701c45d2d$3fe99280$0364a8c0@haruo>
From: "KeiHachi" <keihachi@swissinfo.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>, <bluez-devel@lists.sourceforge.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <20040627125235.GA15938@gmx.net> <001101c45c55$7803b160$0364a8c0@haruo> <20040627171336.GA25886@gmx.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Tue, 29 Jun 2004 01:30:36 +0900

Hi, nicholas.

Thanks for your reply again.

> > I think he will need to spend a little extra time (maybe a few months) 
> > for supporting eSCO. 
> 
> I think if you pay him for supporting eSCO, then it will be very quickly
> integrated.

Thanks for your advice.
It can't be decided on my own responsibility,
but I will input it to our team members when we will study on this topic.


> > Do you mean that offering a headphone with Bluetooth audio functionality
> > to him is necessary to develop A2DP?
> 
> Look here:
> http://sourceforge.net/mailarchive/message.php?msg_id=8643774
> I don"t know whether someone donated anything after this request, but I
> think he can"t get enought. ;)

Thank you very much for this reference of the thread that you have searched.
I also guess he doesn't get enough donation.


> > If you have a few guesses about such a company that provides the 
> > support of using BlueZ, please tell me the name of such a company.
> 
> I don"t know of any...

OK, thank you.
And please forgive me for asking such a rude question.


> > Or, please forgive me for asking this rude question, but,
> > could the developers of BlueZ community provide the support to ensure 
> > the quality,  as counter value for some maintenance fee?
> 
> ..but i am quite sure this might be possible. Marcel while probably
> reply itself. He is the best suited person, for such a job.

Yes, I think so, too.
The problem is whether it is acceptable to ask him to do such a job, or not.
I'm worried that such a business model may be unseemly in the open-source world.
(This is the reason why I ask a question to this mailing-list)


> > If a new profile is testing or has been released immediately 
> > after the development,  probably some bugs are still included.
> > So we think if BlueZ is used for the commercial use, the stable 
> > version is necessary,
> > because a commercial product is required to be a high quality.
> 
> Yeah I understand your problem and IMO you are partly right. There is no
> so strict seperation of a testing and a stable tree. But you have to
> seperate: the generic ACL/RFCOMM support is quite stable. You can use
> it without integrating all those parts which might be considered not
> completely stable. 

Yes, I understand what you say, because of the reply from you and Marcel.


> I personaly wouldn"t use HID or SCO support in a commercial device.

Why won't you use these features in a commercial device?
(This is only my personal interest.)


> > If so, is the modification of the kernel part still stable?
> 
> You mean those -mh patches for 2.6?

Now I understand this part in my mind.
I'm sorry for this confusing question. Please forget this part.


Regards,
KeiHachi







-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
