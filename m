Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 17:08:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 2/2] Add SetFolder function for MAP tracker backend
Message-ID: <20110714140834.GH2770@dell.ger.corp.intel.com>
References: <1310651174-11945-1-git-send-email-bulislaw@linux.com>
 <1310651174-11945-2-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310651174-11945-2-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Jul 14, 2011, Bartosz Szatkowski wrote:
> +static char *root_folder = "/";

Do you intend to change this a runtime in the future? If not, I don't
think you need a special varialble for it.

> +static struct message_folder *get_folder(const char *folder)
> +{
> +	GSList *current = folder_tree->subfolders;
> +	GSList *last;
> +	int i = 1;
> +	char **path;
> +
> +	if (g_strcmp0(folder, "/") == 0)
> +		return folder_tree;
> +
> +	path = g_strsplit(folder, "/", 0);
> +
> +	while (path[i] != NULL) {

This should be a for-loop:

	for (i = 1; path[i] != NULL; i++)

> +		GSList *next = current;

You seem to use this as a simple iterator, so please call it simply l
instead of next;

> +		int find = 0;

This is used as a boolean so please use gboolean instead of an int. I
also think that match_found would be a better name.

> +		while (next != NULL) {

This should be a for-loop too:

	for (l = current; l != NULL; l = g_slist_next(l))

> +static void create_folder_tree()
> +{
> +	struct message_folder *parent, *child;
> +
> +	folder_tree = create_folder("/", NULL);
> +
> +	parent = create_folder("telecom", NULL);
> +	folder_tree->subfolders = g_slist_append(folder_tree->subfolders,
> +						 parent);

Mixed tabs and spaces for indentation in the last line above.

Johan
