Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1279623875-9870-1-git-send-email-rafal.michalski@comarch.com>
References: <1279623875-9870-1-git-send-email-rafal.michalski@comarch.com>
Date: Tue, 20 Jul 2010 14:25:58 +0300
Message-ID: <AANLkTikJmJjZPHApy4P9eFtS3eqYA7Y-y5SFghRnE4ld@mail.gmail.com>
Subject: Re: [PATCH] Fixed problem with incoming calls query
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Rafal Michalski <rafal.michalski@comarch.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Tue, Jul 20, 2010 at 2:04 PM, Rafal Michalski
<rafal.michalski@comarch.com> wrote:
> From: Rafal Michalski <rafal.michalski@comarch.com>
>
> After making some incoming, outgoing, missed calls, history lists of them
> (ich, och, mch) are stored on device. In current implementation queries
> towards tracker for incoming calls include also missed calls.
> So list for incoming calls displayed on paired BT headset/carkit screen
> (e.g. BH-903, CK-200) also contains numbers from missed calls list.
>
> To block adding missed calls list numbers to incoming calls there should
> be added info that incoming call is in fact only answered call. So macros
> additionally include info: "nmo:isAnswered true ." Without this, missed
> calls was treated as incoming calls.
> ---
>  plugins/phonebook-tracker.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 89c612e..98b6410 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -125,6 +125,7 @@
>                "?call a nmo:Call ; "                                   \
>                "nmo:from ?c ; "                                        \
>                "nmo:isSent false . "                                   \
> +               "nmo:isAnswered true ."                                 \
>                "?c a nco:Contact . "                                   \
>        "OPTIONAL { ?c nco:hasPhoneNumber ?h . } "                      \
>        "OPTIONAL { ?c nco:hasEmailAddress ?e . } "                     \
> @@ -144,6 +145,7 @@
>                "?call a nmo:Call ; "                                   \
>                "nmo:from ?c ; "                                        \
>                "nmo:isSent false . "                                   \
> +               "nmo:isAnswered true ."                                 \
>                "?c a nco:Contact . "                                   \
>        "OPTIONAL { ?c nco:hasPhoneNumber ?h . } "                      \
>        "} ORDER BY DESC(nmo:receivedDate(?call))"
> --
> 1.6.3.3
>

Actually this is not completely correct, this nmo are a list of
properties so only the last one will have the . , something like this:

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 89c612e..696b544 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -124,7 +124,8 @@
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
-		"nmo:isSent false . "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered true ."					\
 		"?c a nco:Contact . "					\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
@@ -143,7 +144,8 @@
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
-		"nmo:isSent false . "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered true ."					\
 		"?c a nco:Contact . "					\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
@@ -181,7 +183,7 @@
 		"nmo:to ?c ; "						\
 		"nmo:isSent true . "					\
 		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "				\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
 	"} ORDER BY DESC(nmo:sentDate(?call))"

 #define COMBINED_CALLS_QUERY						\
-- 
1.6.1


-- 
Luiz Augusto von Dentz
Computer Engineer
