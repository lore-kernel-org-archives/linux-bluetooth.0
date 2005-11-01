Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
In-Reply-To: <20051031233610.GA14937@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051031224006.GA14057@localhost.localdomain>
	 <1130799900.31561.38.camel@blade>
	 <20051031233610.GA14937@localhost.localdomain>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 1 Nov 2005 10:33:11 -0200

Hi,

These changes are very nice! The effort to change the paths will be small.

Now, /org/bluez/Device should be registered using a fallback approach
and this "root" path should reply for messages sent to a
invalid/unregistered device path. The Manager path, can be registered
as a normal path without care about child paths.

Considering that local and remote configuration tasks will be
available under the same path, we need change the child path
register/unregister action. When a device is turned DOWN the path
can't be unregistered anymore.  We can use the attribute "status" of
the struct "profile_obj_path_data" to control this. I think this
attribute was initially added with this purpose :)
Any comment? Does someone has another suggestion?

Remove the default device path good, a default path was inserting
confusion when sending signals and replies.

Regards,
Claudio.


On 10/31/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> Hi Marcel,
>
> On Tue, Nov 01, 2005, Marcel Holtmann wrote:
> > Feel free to send in a patch. For me these proposed changes are soundin=
g
> > perfectly sane and I am happy to try them out. However it would be grea=
t
> > if you can include some small test applications written in Python like
> > Eduardo did.
>
> Thanks for your encouraging reply! I don't yet have a patch for the
> changes, but I'll try to produce one during tommorow (Tuesday). I'll
> also try to provide some small python test apps as well as update the
> pygtk app I have been working on.
>
> Johan
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
