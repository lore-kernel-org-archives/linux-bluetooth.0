Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1241056888.3389.11.camel@localhost.localdomain>
References: <1241055744-12140-1-git-send-email-ngh@isomerica.net>
	 <1241056888.3389.11.camel@localhost.localdomain>
Date: Thu, 30 Apr 2009 13:12:00 -0300
Message-ID: <6b53b1990904300912x666359c9uddb638b5b3436151@mail.gmail.com>
Subject: Re: [PATCH] *** SUBJECT HERE ***
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Nathan Holstein <nathan@lampreynetworks.com>
Cc: ngh@isomerica.net, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

On Wed, Apr 29, 2009 at 11:01 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Nathan,
>
>> This is a revamping of the previous patches that I submited. =A0I starte=
d from
>> scratch, rebase all the changes onto the latest bluetooth-testing (2.6.3=
0-rc3).
>> While applying the changes, I attempted to clean up the code and apply t=
he
>> input from Marcel and Gustavo.
>>
>> Unfortunately, I did not get a chance to test this for regressions vs. t=
he
>> previous version of the code. =A0I did remove the code which segmented o=
utgoing
>> PDUs: it wouldn't have worked with the current tx window=3D1, and would =
have
>> produced memory leaks.
>>
>> The code is available from git://staticfree.info/git/el2cap on branch "e=
rtm".
>
> no idea why are using a branch for this. Just a remote repository should
> be enough. Anyhow you have to add Signed-off-by statements to your
> patches. Otherwise I can't apply them.

Also add -n to your git format-patch options to number the
patches(e.g. [PATCH 01/07]...)

>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Gustavo F. Padovan
http://padovan.org
