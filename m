Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Don't show (null) in wizard
From: Bastien Nocera <hadess@hadess.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mario_Limonciello@Dell.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <1223274346.28401.54.camel@macbook.infradead.org>
References: <FA7963CC89065B49AED46A6F797F0FA6F286AA@AUSX3MPC128.aus.amer.dell.com>
	 <1223274346.28401.54.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 07:43:05 +0100
Message-Id: <1223275385.3743.1.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-10-06 at 07:25 +0100, David Woodhouse wrote:
> On Mon, 2008-10-06 at 01:21 -0500, Mario_Limonciello@Dell.com wrote:
> > I've noticed that the wizard will show (null) if the device name is
> > not yet recognized when pairing.  This is a bit confusing to the user
> > experience.  The attached patch makes the behavior a little bit
> > better.
> 
> Thanks; I noticed that too a couple of days ago but hadn't got round to
> the patch yet.
> 
> Perhaps showing the bdaddr would be better, though?

That should fix both problems:

diff --git a/wizard/main.c b/wizard/main.c
index 3accd7f..3c9e017 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -351,7 +351,7 @@ static void select_callback(GtkTreeSelection *selection, gpointer user_data)
                gtk_tree_model_get(model, &iter,
                                BLUETOOTH_COLUMN_PAIRED, &paired,
                                BLUETOOTH_COLUMN_ADDRESS, &address,
-                               BLUETOOTH_COLUMN_NAME, &name,
+                               BLUETOOTH_COLUMN_ALIAS, &name,
                                BLUETOOTH_COLUMN_TYPE, &type, -1);
 
                if (paired == TRUE)


