Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jun 2013 12:08:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/5] client: Display command even with no
 description
Message-ID: <20130619090850.GA4161@x220>
References: <1371586427-7909-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1371586427-7909-4-git-send-email-lucas.demarchi@profusion.mobi>
 <22954997-7A12-45B3-BA58-13F02AFE3184@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22954997-7A12-45B3-BA58-13F02AFE3184@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Lucas,

On Wed, Jun 19, 2013, Marcel Holtmann wrote:
> Hi Lucas,
> 
> > Having no description doesn't mean it's not an available command. So add
> > command to the output of "help" command, even if it has no description.
> > ---
> > client/main.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/client/main.c b/client/main.c
> > index b0a66d8..54af807 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -1182,10 +1182,9 @@ static void rl_handler(char *input)
> > 	printf("Available commands:\n");
> > 
> > 	for (i = 0; cmd_table[i].cmd; i++) {
> > -		if (cmd_table[i].desc)
> > -			printf("\t%s %s\t%s\n", cmd_table[i].cmd,
> > +		printf("\t%s %s\t%s\n", cmd_table[i].cmd,
> > 						cmd_table[i].arg ? : "    ",
> > -						cmd_table[i].desc);
> > +						cmd_table[i].desc ? : "");
> 
> 
> if I remember this correctly, then I was doing it to be able to hide
> commands from the help output. Mainly commands that are on purpose
> duplicates.

So the right fix is to add the missing descriptions then? Lucas, can you
provide an updated patch that does this?

Johan
